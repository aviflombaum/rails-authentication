class UserMailer < ApplicationMailer
  def password_reset(user)
    @user = user
    mail(to: @user.email, subject: "Reset Your Password")
  end

  def login_link(user)
    @user = user
    mail(to: @user.email, subject: "Your Login Link")
  end
end
