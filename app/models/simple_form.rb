class SimpleForm < FillablePdfForm
  attr_accessor :form
  def initialize(form)
    self.form = form
    super()
  end

  protected

  def fill_out
    fill 'full-name', form.name
  end
end
