class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  layout false

  def home
    render 'home/home'

  end
end
