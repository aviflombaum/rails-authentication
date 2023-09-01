class LoginToken
  include ActiveModel::Model

  attr_accessor :user, :email

  def save
    @user = User.find_by(email: email)
    if @user
      @user.login_token = SecureRandom.urlsafe_base64
      @user.login_token_expires_at = 1.hour.from_now
      @user.save
      UserMailer.login_link(@user).deliver_later
    end
  end

  def expire!
    @user.update(login_token: nil, login_token_expires_at: nil)
  end

  def self.find_by_valid_token(token)
    user = User.where("login_token = ? AND login_token_expires_at > ?", token, Time.current).first
    if user
      new.tap { |l| l.user = user }
    end
  end
end
