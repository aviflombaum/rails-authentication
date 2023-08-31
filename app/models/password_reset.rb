class PasswordReset
  include ActiveModel::Model

  attr_accessor :user, :email, :password, :password_confirmation

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

  def self.find_by_valid_token(token)
    User.where("reset_password_token = ? AND reset_password_token_expires_at > ?", token, Time.now).first
  end
end
