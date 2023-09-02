require "rails_helper"

RSpec.describe Tokenable, type: :model do
  let(:user) { create(:user) }
  let(:tokenable) { Class.new { include Tokenable }.new }

  before do
    tokenable.email = user.email
    tokenable.save
    user.reload
  end

  describe "#save" do
    it "assigns a token to the user" do
      expect(user.send(tokenable.class.token_field)).not_to be_nil
    end

    it "sets the token expiration time" do
      expect(user.send("#{tokenable.class.token_field}_expires_at")).not_to be_nil
    end
  end

  describe "#expire!" do
    before { tokenable.expire! }

    it "removes the token from the user" do
      expect(user.reload.send(tokenable.class.token_field)).to be_nil
    end

    it "removes the token expiration time" do
      expect(user.reload.send("#{tokenable.class.token_field}_expires_at")).to be_nil
    end
  end

  describe ".find_by_valid_token" do
    context "when the token is valid" do
      it "returns the user" do
        expect(tokenable.class.find_by_valid_token(user.send(tokenable.class.token_field)).user).to eq(user)
      end
    end

    context "when the token is not valid" do
      it "returns nil" do
        expect(tokenable.class.find_by_valid_token("invalid")).to be_nil
      end
    end
  end
end
