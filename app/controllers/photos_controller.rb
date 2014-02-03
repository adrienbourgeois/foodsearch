class PhotosController < ApplicationController

  def index
    render json: Photo.around(params[:latitude],params[:longitude],50).to_json(only: [:name, :vicinity, :tags, :image_thumbnail, :image_standard_resolution, :city_name, :instagram_url])
  end

  def show
    render json: Photo.find(params[:id])
  end

end
