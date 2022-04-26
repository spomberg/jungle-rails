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
  end
end
