class PhotosController < ApplicationController

  def index
    render json: Photo.where(checked:true).to_json(include: :place)
  end

  def show
    render json: Photo.find(params[:id])
  end

end
