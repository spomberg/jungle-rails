class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: ENV['HTTP_BASIC_USER'], 
                               password: ENV['HTTP_BASIC_PASSWORD']

  def index
    @category = Category.order(name: :asc).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(:name)

    if @category.save
      redirect_to [:admin, :categories], notice: "Category created!"
    else
      render :new
    end
    
  end

end
