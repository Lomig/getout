# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: %i[index home], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: %i[index home], unless: :skip_pundit?

  def default_url_options
    { host: ENV['DOMAIN'] || 'localhost:3000' }
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def after_sign_in_path_for(resource)
    UserArtist.where(user: resource).destroy_all
    resource.add_spotify_artists
    if resource.viewed_tastes_screen
      super
    else
      resource.add_spotify_genres
      tastes_path
    end
  end
end
