class UserNotifierMailer < ApplicationMailer

  def inform(new_user)
    mail(to: new_user, subject: "Activate Your Account")
  end

end
