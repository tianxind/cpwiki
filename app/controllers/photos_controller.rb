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
    @photo.source = Photo::UPLOAD
    directory = Rails.root.join('public', 'images')
    if File.directory?(directory) then
      puts "<<<<<<<<<<<<<<<<<<<<Directory #{directory} exists<<<<<<<<<<<<<"
    else
      puts "<<<<<<<<<<<<<<<<<<NO DIRECTORY #{directory}<<<<<<<<<<<<<<<<<<"
    end
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
    @photo.source = Photo::UPLOAD
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
    @photo = Photo.find_by_filename(CGI.unescape(params[:src]))
    if @photo
      redirect_to :action => :show, :id => @photo.id
    end
  end

  # def self.processWikiImages(wiki_content, all_images)
  #   if all_images != nil
  #     deleteUnusedImages(Photo.getUnusedImages(wiki_content, all_images))
  #   end
  #     saveAllWebImages(Photo.getWebImages(wiki_content))
  # end

  # def self.saveAllWebImages(web_images)
  #   for image in web_images
  #     if Photo.find_by_filename(image) == nil 
  #       @photo = Photo.new
  #       @photo.user_id = current_user.id
  #       @photo.filename = image
  #       @photo.date_time = DateTime.now
  #       @photo.save
  #     end
  #   end
  # end

  #  def self.deleteUnusedImages(unused_images)
  #   unused_images.each do |f|
  #     image = Photo.find_by_filename(f)
  #     if image != nil
  #       image.destroy
  #       File.delete(Rails.root.join('public', 'images', image.filename))
  #     end
  #   end
  # end
end