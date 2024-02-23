# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  before_action :authenticate_user! # from Devise
  include Pundit::Authorization
  before_action :load_chatrooms

  # Pundit: allow-list approach
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Define the home action
  # def home
  #    render 'home'
  # end
  def load_chatrooms
    @chatrooms = Chatroom.all
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /^rails_admin/ || params[:action] == 'home'
  end
end
