module Tokenable
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Model
    attr_accessor :user, :email
  end

  def save
    @user = User.find_by(email: email)
    if @user
      @user.send("#{self.class.token_field}=", SecureRandom.urlsafe_base64)
      @user.send("#{self.class.token_field}_expires_at=", 1.hour.from_now)
      @user.save
    end
  end

  def expire!
    @user.update("#{self.class.token_field}": nil, "#{self.class.token_field}_expires_at": nil)
  end

  class_methods do
    def find_by_valid_token(token)
      user = User.where("#{token_field} = ? AND #{token_field}_expires_at > ?", token, Time.current).first
      if user
        new.tap { |l| l.user = user }
      end
    end

    def token_field
      @token_field ||= name.to_s.underscore
    end
  end
end
