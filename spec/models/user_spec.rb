require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    context "given that all fields are entered correctly" do
      it "saves successfully" do
        user = User.new(name: "abc", email: "abc@gmail.com", password: "12345678", password_confirmation: "12345678").save
        expect(user).to eq(true)
      end
    end

    context "given that the password and password confirmation don't match" do
      it "doesn't save successfully" do
        user = User.new(name: "abc", email: "abc@gmail.com", password: "12345678", password_confirmation: "12345677")
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
        expect(user.errors[:password]).to eq(["can't be blank", "can't be blank", "is too short (minimum is 8 characters)"])
      end
    end

    context "given that the password confirmation field is blank" do
      it "doesn't save successfully" do
        user = User.new(name: "abc", email: "abc@gmail.com", password: "12345678", password_confirmation: nil)
        validation = user.save
        expect(validation).to eq(false)
        expect(user.errors[:password_confirmation]).to eq(["can't be blank"])
      end
    end

    context "given that name field is blank" do
      it "doesn't save successfully" do
        user = User.new(name: nil, email: "abc@gmail.com", password: "12345678", password_confirmation: "12345678")
        validation = user.save
        expect(validation).to eq(false)
        expect(user.errors[:name]).to eq(["can't be blank"])
      end
    end

    context "given that email field is blank" do
      it "doesn't save successfully" do
        user = User.new(name: "abc", email: nil, password: "12345678", password_confirmation: "12345678")
        validation = user.save
        expect(validation).to eq(false)
        expect(user.errors[:email]).to eq(["can't be blank"])
      end
    end

    context "given that the email entered is not unique" do
      it "doesn't save successfully" do
        user1 = User.new(name: "abc", email: "abc@gmail.com", password: "12345678", password_confirmation: "12345678").save
        user2 = User.new(name: "abc", email: "abc@gmail.com", password: "12345678", password_confirmation: "12345678")
        validation = user2.save
        expect(validation).to eq(false)
        expect(user2.errors[:email]).to eq(["has already been taken"])
      end
    end

    context "given that the email entered has been used but is in upper case" do
      it "doesn't save successfully" do
        user1 = User.new(name: "abc", email: "abc@gmail.com", password: "12345678", password_confirmation: "12345678").save
        user2 = User.new(name: "abc", email: "ABC@GMAIL.COM", password: "12345678", password_confirmation: "12345678")
        validation = user2.save
        expect(validation).to eq(false)
        expect(user2.errors[:email]).to eq(["has already been taken"])
      end
    end

    context "password has less than 8 characters" do
      it "doesn't save successfully" do
        user = User.new(name: "abc", email: "abc@gmail.com", password: "1234567", password_confirmation: "1234567")
        validation = user.save
        expect(validation).to eq(false)
        expect(user.errors[:password]).to eq(["is too short (minimum is 8 characters)"])
      end
    end
  end

  describe '.authenticate_with_credentials' do
    context "given that email and password match" do
      it "authenticates the user" do
        user = User.new(name: "abc", email: "abc@gmail.com", password: "12345678", password_confirmation: "12345678")
        user.save
        expect(User.authenticate_with_credentials("abc@gmail.com", "12345678").id).to eq(user.id)
      end
    end

    context "given that email and password don't match" do
      it "doesn't authenticates the user" do
        user = User.new(name: "abc", email: "abc@gmail.com", password: "12345678", password_confirmation: "12345678")
        user.save
        expect(User.authenticate_with_credentials("abc@gmail.com", "12345677")).to eq(nil)
      end
    end

    context "given that there are extra spaces in the email field" do
      it "authenticates the user" do
        user = User.new(name: "abc", email: "abc@gmail.com", password: "12345678", password_confirmation: "12345678")
        user.save
        expect(User.authenticate_with_credentials(" abc@gmail.com " , "12345678").id).to eq(user.id)
      end
    end
  end
end
