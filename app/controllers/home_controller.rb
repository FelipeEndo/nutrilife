class HomeController < ApplicationController
  layout 'site'
  def index
    @blogs = Blog.all
    @categories = Category.all
    @admin = Admin.first
  end
end