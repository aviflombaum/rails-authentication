class PasswordReset
  include ActiveModel::Model

  attr_accessor :user, :email

  validates :user, presence: true

  def save
    @user = User.find_by(email: email)
    if @user
      @user.reset_password_token = SecureRandom.urlsafe_base64
      @user.reset_password_token_expires_at = 24.hours.from_now
      @user.save
      UserMailer.password_reset(@user).deliver_now
    end
  end
end
