class FillablePdfForm
  attr_writer :template_path
  attr_reader :attributes

  def initialize
    fill_out
  end

  def export(output_file_path=nil)
    pdfs_path = Rails.root.join('tmp', 'pdfs')
    Dir.mkdir(pdfs_path, 0700) unless File.exists?(pdfs_path)
    output_path = output_file_path || "#{Rails.root}/tmp/pdfs/#{SecureRandom.uuid}.pdf"
    pdftk.fill_form template_path, output_path, attributes
    output_path
  end

  def get_field_names
    pdftk.get_field_names template_path
  end

  def template_path
    @template_path ||= "#{Rails.root}/lib/forms/w9-form.pdf"
  end

  protected

  def attributes
    @attributes ||= {}
  end

  def fill(key, value)
    attributes[key.to_s] = value
  end

  def pdftk
    @pdftk ||= PdfForms.new(ENV['PDFTK_PATH'] || '/usr/local/bin/pdftk')
  end

  def fill_out
    raise 'Must be overridden by child class'
  end
end
