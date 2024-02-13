class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    render 'home/home'
  end
end
