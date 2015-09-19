class FormsController < ApplicationController
  def index
    @forms = Form.all
  end

  def new
    @form = Form.new
  end

  def create
    @form = Form.new(form_params)
    if @form.save
      redirect_to forms_path
    else
      Rails.logger.error "error_submitting_form"
      flash[:error] = "Error submitting form"
      redirect_to forms_path
    end
  end

  def generate_pdf
    @form = Form.find(form_params[:id])
    @form.generate_pdf
    redirect_to forms_path
  end

  private
  def form_params
    params.require(:form).permit(:name, :id)
  end
end
