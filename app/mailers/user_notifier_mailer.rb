class UserNotifierMailer < ApplicationMailer

  def inform(email)
    mail(to: email, subject: "Activate Your Account")
  end

end
