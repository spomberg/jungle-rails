require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    context "given that all fields are entered" do
      it "should save successfully" do
        cat1 = Category.new
        cat1.save
        product = Product.new(name: "abc", price_cents: 12, quantity: 2, category: cat1).save
        expect(product).to eq(true)
      end
    end

    context "given that the name field is missing" do
      it "should not save" do
        cat1 = Category.new
        cat1.save
        product = Product.new(name: nil, price_cents: 12, quantity: 2, category: cat1)
        validation = product.validate
        expect(validation).to eq(false) 
        expect(product.errors[:name]).to eq(["can't be blank"]) 
      end
    end

    context "given that the price field is missing" do
      it "should not save" do
        cat1 = Category.new
        cat1.save
        product = Product.new(name: "abc", price_cents: nil, quantity: 2, category: cat1)
        validation = product.validate
        expect(validation).to eq(false) 
        expect(product.errors[:price]).to eq(["is not a number", "can't be blank"]) 
      end
    end
  end
end
