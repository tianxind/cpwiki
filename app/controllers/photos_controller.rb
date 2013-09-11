class PhotosController < ApplicationController
  before_filter :authenticate_user!, :only => [:create]
  
  def gen_image_filename(original_filename)
    return @photo.date_time.to_s(:number) + "_" + original_filename
  end

  def create
    uploaded_io = params[:file]
    @photo = Photo.new
    @photo.user_id = current_user.id
    @photo.date_time = DateTime.now
    @photo.filename = gen_image_filename(uploaded_io.original_filename)
    respond_to do |format|
      if @photo.save
        File.open(Rails.root.join('public', 'images', @photo.filename), 'wb') do |file|
          file.write(params[:file].read)
        end
        format.js
      end
    end
  end
  
  def update_profile_image
    uploaded_io = params[:profile_image]
    @photo = Photo.new
    @photo.user_id = current_user.id
    @photo.date_time = DateTime.now
    @photo.filename = gen_image_filename(uploaded_io.original_filename)
    respond_to do |format|
      if @photo.save
        File.open(Rails.root.join('public', 'images', @photo.filename), 'wb') do |file|
          file.write(params[:profile_image].read)
        end
        format.js
      end
    end
  end

  def show
    if params[:id]
      @photo = Photo.find_by_id(params[:id])
    end
    @tags = @photo.tags
  end

  def create_web_photo
    @photo = Photo.new
    @photo.user_id = current_user.id
    @photo.date_time = DateTime.now
    @photo.filename = params[:photo][:filename]
    respond_to do |format|
      if @photo.save
        format.js
      end
    end
  end

  def lookup
    @photo = Photo.find_by_filename(params[:src])
    if @photo
      redirect_to :action => :show
    end
  end
end