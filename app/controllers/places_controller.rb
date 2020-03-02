# frozen_string_literal: true

class PlacesController < ApplicationController
  def index
    # binding.pry
    @query = params[:query]
    current_scope = policy_scope(Place)
    current_scope = Place.policy_scope_by_distance(@query, current_scope) if @query.present?

    @places = Place.policy_scope_by_genre(current_user, current_scope)

    if @query.present?
      @places.each { |place| place.distance_from(@query) }
             .sort_by!(&:distance)
    end

    @markers = @places.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        infoWindow: render_to_string(partial: 'info_window', locals: { place: place }),
        image_url: helpers.asset_url('marker.png')
      }
    end
  end

  def show
    @place = Place.find(params[:id])
    @like = Like.where(user: current_user, place: @place).first
    authorize @place
  end
end
