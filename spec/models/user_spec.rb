require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    context "given that all fields are entered correctly" do
      it "saves successfully" do
        user = User.new(name: "abc", email: "abc@gmail.com", password: "abc", password_confirmation: "abc").save
        expect(user).to eq(true)
      end
    end

    context "given that the password and password confirmation don't match" do
      it "doesn't save successfully" do
        user = User.new(name: "abc", email: "abc@gmail.com", password: "abc", password_confirmation: "abc1")
        validation = user.save
        expect(validation).to eq(false)
        expect(user.errors[:password_confirmation]).to eq(["doesn't match Password"])
      end
    end

    context "given that the password fields are both blank " do
      it "doesn't save successfully" do
        user = User.new(name: "abc", email: "abc@gmail.com", password: nil, password_confirmation: nil)
        validation = user.save
        expect(validation).to eq(false)
        expect(user.errors[:password]).to eq(["can't be blank", "can't be blank"])
      end
    end

    context "given that the password confirmation field is blank " do
      it "doesn't save successfully" do
        user = User.new(name: "abc", email: "abc@gmail.com", password: "abc", password_confirmation: nil)
        validation = user.save
        expect(validation).to eq(false)
        expect(user.errors[:password_confirmation]).to eq(["can't be blank"])
      end
    end
  end
end
