class UserNotifierMailer < ApplicationMailer

  def activate(email)
    mail(to: email, subject: "Activate Your Account")
  end

end
