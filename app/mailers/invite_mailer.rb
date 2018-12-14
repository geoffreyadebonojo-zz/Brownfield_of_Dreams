class InviteMailer < ApplicationMailer
  def invite(user, data, host)
    @host = host
    @user = user
    @data = data
    mail(to: data[:email], subject: "#{data[:login]}, Please Join Brownfield of Dreams")
  end
end
