class Admin::DashboardController < ApplicationController
  def show
    @dashboard = { number_of_products: Product.count, number_of_categories: Category.count }
  end
end
