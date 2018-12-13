class ActivationController < ApplicationController
  def create
    UserNotifierMailer.inform(params[:email]).deliver_now
    flash[:notice] = "Email Send"
    redirect_to dashboard_path
  end

end
