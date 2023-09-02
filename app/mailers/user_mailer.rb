class UserMailer < ApplicationMailer
  def password_reset_token(user)
    @user = user
    mail(to: @user.email, subject: "Reset Your Password")
  end

  def login_token(user)
    @user = user
    mail(to: @user.email, subject: "Your Login Link")
  end
end
