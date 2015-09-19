class Form < ActiveRecord::Base
  validates :name, presence: true

  BUCKET = AWS::S3.new.buckets[ENV['FORMS_BUCKET']]

  def generate_pdf
    pdf_filepath = SimpleForm.new(self).export
    filename = File.basename(pdf_filepath)
    key = "pdfs/#{Time.now.year}/#{filename}"
    BUCKET.objects[key].write(File.read(pdf_filepath))
    update_attributes(file_path: key)
  end

  def pdf_form_link
    if file_path
      object = BUCKET.objects[URI.decode(file_path)]
      object.url_for(:read).to_s
    else
      Rails.logger.info "no_file_path id=#{id}"
      nil
    end
  end
end
