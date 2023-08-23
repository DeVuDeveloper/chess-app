class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @games = Game.all
    @game = Game.new
  end
  
  
  def contact_new
    @contact_form = if current_user
      ContactForm.new(
        email: current_user.email
      )
    else
      ContactForm.new
    end
  end

  def contact_create
    @contact_form = ContactForm.new(contact_form_params)
    if @contact_form.save
      UserMailer.contact(@contact_form).deliver
      flash.now[:notice] = "Your email is sent"
      @contact_form.text = ""
    end
    render :contact_new
  end

  private

  def contact_form_params
    params.require(:contact_form).permit(
      *ContactForm::FIELDS
    )
  end
end
