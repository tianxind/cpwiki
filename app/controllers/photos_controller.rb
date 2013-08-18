class PhotosController < ApplicationController
  before_filter :authenticate_user!, :only => [:create]
  
  def create
    uploaded_io = params[:file]
    @photo = Photo.new
    @photo.user_id = current_user.id
    @photo.date_time = DateTime.now
    @photo.filename = current_user.id.to_s + "_" + uploaded_io.original_filename
    respond_to do |format|
      if @photo.save
        File.open(Rails.root.join('public', 'images', @photo.filename), 'wb') do |file|
          file.write(params[:file].read)
        end
      end
    end
  end
end