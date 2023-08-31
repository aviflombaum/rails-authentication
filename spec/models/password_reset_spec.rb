require "rails_helper"

RSpec.describe PasswordReset, type: :model do
  let(:user) { create(:user) }
  let(:password_reset) { PasswordReset.new(email: user.email) }

  describe "#save" do
    context "when user is found" do
      it "updates the user with a reset token and expiration time" do
        expect { password_reset.save }.to change { user.reload.reset_password_token }.from(nil).and change { user.reload.reset_password_token_expires_at }.from(nil)
      end

      it "sends a password reset email" do
        expect(UserMailer).to receive(:password_reset).with(user).and_call_original
        password_reset.save
      end
    end

    context "when user is not found" do
      let(:password_reset) { PasswordReset.new(email: "nonexistent@example.com") }

      it "does not send a password reset email" do
        expect(UserMailer).not_to receive(:password_reset)
        password_reset.save
      end
    end
  end
end
