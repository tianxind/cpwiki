class PhotosController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :deleteUnusedImages]
  
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

  def deleteUnusedImages(wiki_content, all_images)
    pos = 0
    files = Array.new
    while pos < wiki_content.length do
      # Get file name of the image
      match_data = wiki_content.match(/<img(.+)src=\"\/images\/(.+)\">/, pos)
      if match_data != nil
        files.push(match_data[2])
        pos += 4
      else
        break
      end
    end
  
    puts "<<<<<<<<<<<<<<<<<<<all images in wikisource<<<<<<<<<<<<<<"
    puts files
    deleted_files = all_images.reject {|i| files.include? i}
    puts "<<<<<<<<<<<<<<<<<<<<Deleted files<<<<<<<<<<<<<<<<<<<<<<<"
    puts deleted_files
    # Delete all entries from database and the files on our server
    deleted_files.each do |f|
      image = Photo.find_by_filename(f)
      image.destroy
      File.delete(Rails.root.join('public', 'images', image.filename))
    end
  end
end