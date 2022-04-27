require 'rails_helper'

RSpec.describe User, type: :model do
  context "given that all fields are entered correctly" do
    it "saves successfully" do
      user = User.new(name: "abc", email: "abc@gmail.com", password: "abc", password_confirmation: "abc").save
      expect(user).to eq(true)
    end
  end

  context "given that the password and password confirmation don't match" do
    it "not save successfully" do
      user = User.new(name: "abc", email: "abc@gmail.com", password: "abc", password_confirmation: "abc1")
      validation = user.save
      expect(validation).to eq(false)
      expect(user.errors[:password_confirmation]).to eq(["doesn't match Password"])
    end
  end
end
