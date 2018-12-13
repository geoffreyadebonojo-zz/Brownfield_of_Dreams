class UsersController < ApplicationController
  def show
    @facade = UserDashboardFacade.new(current_user)
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id

      UserNotifierMailer.activate(current_user.email).deliver_now
      flash[:notice] = "Email Sent"

      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      redirect_to register_path
    end
  end

  def update
    user = User.find(current_user.id)
    auth = request.env["omniauth.auth"]
    user.from_omniauth(auth)
    redirect_to dashboard_path
  end

 def activate
   user = User.find(current_user.id)
   user.activated = true
   user.save
 end


  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
