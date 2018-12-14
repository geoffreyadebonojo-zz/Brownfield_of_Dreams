class InviteController < ApplicationController

  def new
  end

  def create

    data = InviteService.new(invite_params[:handle], current_user.token).get_json
    if data[:email]
      site = request.env["HTTP_HOST"]
      InviteMailer.invite(current_user, data, site).deliver_now
      flash[:success] = "Successfully sent invite!"
    else
      flash[:notice] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end

  private

  def invite_params
    params.permit(:handle)
  end

end
