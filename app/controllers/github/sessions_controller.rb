class Github::SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    current_user.from_omniauth(auth)
    redirect_to dashboard_path
  end

end
