# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit::Authorization

  # Pundit: allow-list approach
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Define the home action
  # def home
  #    render 'home'
  # end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /^rails_admin/ || params[:action] == 'home'
  end
end
