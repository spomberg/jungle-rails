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

    context "given that the password fields are both blank" do
      it "doesn't save successfully" do
        user = User.new(name: "abc", email: "abc@gmail.com", password: nil, password_confirmation: nil)
        validation = user.save
        expect(validation).to eq(false)
        expect(user.errors[:password]).to eq(["can't be blank", "can't be blank"])
      end
    end

    context "given that the password confirmation field is blank" do
      it "doesn't save successfully" do
        user = User.new(name: "abc", email: "abc@gmail.com", password: "abc", password_confirmation: nil)
        validation = user.save
        expect(validation).to eq(false)
        expect(user.errors[:password_confirmation]).to eq(["can't be blank"])
      end
    end

    context "given that name field is blank" do
      it "doesn't save successfully" do
        user = User.new(name: nil, email: "abc@gmail.com", password: "abc", password_confirmation: "abc")
        validation = user.save
        expect(validation).to eq(false)
        expect(user.errors[:name]).to eq(["can't be blank"])
      end
    end

    context "given that email field is blank" do
      it "doesn't save successfully" do
        user = User.new(name: "abc", email: nil, password: "abc", password_confirmation: "abc")
        validation = user.save
        expect(validation).to eq(false)
        expect(user.errors[:email]).to eq(["can't be blank"])
      end
    end

    context "given that the email entered is not unique" do
      it "doesn't save successfully" do
        user1 = User.new(name: "abc", email: "abc@gmail.com", password: "abc", password_confirmation: "abc").save
        user2 = User.new(name: "abc", email: "abc@gmail.com", password: "abc", password_confirmation: "abc")
        validation = user2.save
        expect(validation).to eq(false)
        expect(user2.errors[:email]).to eq(["has already been taken"])
      end
    end

    context "given that the email entered has been used but is in upper case" do
      it "doesn't save successfully" do
        user1 = User.new(name: "abc", email: "abc@gmail.com", password: "abc", password_confirmation: "abc").save
        user2 = User.new(name: "abc", email: "ABC@GMAIL.COM", password: "abc", password_confirmation: "abc")
        validation = user2.save
        expect(validation).to eq(false)
        expect(user2.errors[:email]).to eq(["has already been taken"])
      end
    end
  end
end
