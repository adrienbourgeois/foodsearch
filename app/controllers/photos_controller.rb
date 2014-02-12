class PhotosController < ApplicationController

  def index
    user_latitude = params[:latitude]
    user_longitude = params[:longitude]
    photos_js = JSON.parse Photo.around(params[:latitude],params[:longitude],50).to_json(only: [:name, :vicinity, :tags, :image_thumbnail, :image_standard_resolution, :city_name, :instagram_url, :latitude, :longitude])
    photos_js.each do |photo|
      photo['distance'] = Geocoder::Calculations.distance_between([user_latitude,user_longitude], [photo['latitude'],photo['longitude']]).round(2)
    end
    render json: photos_js
  end

  def show
    render json: Photo.find(params[:id])
  end

end
