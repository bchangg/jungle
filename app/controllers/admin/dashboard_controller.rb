# frozen_string_literal: true

class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_NAME'], password: ENV['ADMIN_PASSWORD']

  def show
    @products = Product.all
    @categories = Category.all
  end
end
