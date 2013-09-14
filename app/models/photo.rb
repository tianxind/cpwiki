#!/bin/env ruby
# encoding: utf-8
class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :tags
  
  attr_accessible :filename, :user_id, :date_time
  validates :filename, :presence => { :message => "不能为空！" }

  HUMANIZED_ATTRIBUTES = {
    :filename => "文件名"
  }

  # Enum for source attribute
  WEB = 0
  UPLOAD = 1

  # def self.deleteUnusedImages(wiki_content, all_images)
  #   pos = 0
  #   files = Array.new
  #   while pos < wiki_content.length do
  #     # Get file name of the image
  #     match_data = wiki_content.match(/<img(.+)src=\"\/images\/(.+)\">/, pos)
  # match_data = wiki.match(/<img(.+)src=\"\/images\/(.+)\">/, 0)
  #     if match_data != nil
  #       files.push(match_data[2])
  #       pos += 4
  #     else
  #       break
  #     end
  #   end
  #   puts "<<<<<<<<<<<<<<<<<<<all images in wikisource<<<<<<<<<<<<<<"
  #   puts files
  #   deleted_files = all_images.reject {|i| files.include? i}
  #   puts "<<<<<<<<<<<<<<<<<<<<Deleted files<<<<<<<<<<<<<<<<<<<<<<<"
  #   puts deleted_files
  #   # Delete all entries from database and the files on our server
  #   deleted_files.each do |f|
  #     image = Photo.find_by_filename(f)
  #     image.destroy
  #     File.delete(Rails.root.join('public', 'images', image.filename))
  #   end
  # end
  # "<img class=\"resize wiki_image\" src=\"https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcR4NMgYqPGZ2CZ_czoB4elX5wzuGuapCS16VuNMwTjNN2kNGSwq\" type=\"web\"><div><br></div><div><img class=\"resize wiki_image\" src=\"/images/20130914195828_Makise.Kurisu.full.484550.jpg\"><br></div>"

  def self.processWikiImages(wiki_content, all_images, user_id)
    if all_images != nil
      deleteUnusedImages(getUnusedImages(wiki_content, all_images))
    end
    saveAllWebImages(getWebImages(wiki_content), user_id)
  end

  def self.deleteUnusedImages(unused_images)
    unused_images.each do |f|
      image = Photo.find_by_filename(f)
      if image != nil
        image.destroy
        File.delete(Rails.root.join('public', 'images', image.filename))
      end
    end
  end

  def self.saveAllWebImages(web_images, user_id)
    for image in web_images
      if Photo.find_by_filename(image) == nil 
        @photo = Photo.new
        @photo.user_id = user_id
        @photo.filename = image
        @photo.date_time = DateTime.now
        @photo.source = WEB
        @photo.save
      end
    end
  end

  def self.getWebImages(wiki_content)
    pos = 0
    web_images = Array.new
    while pos < wiki_content.length do
      # Get file name of the image
      match_data = wiki_content.match(/<img class=\"resize wiki_image\" src=\"([^>]+)\" type=\"web\">/, pos)
      if match_data != nil
        web_images.push(match_data[1])
        pos += wiki_content.index(match_data[0]) + match_data[0].length
      else
        break
      end
    end
 
    puts "<<<<<<<<<<<<<<<<<<all web images<<<<<<<<<<<<<<<<<<"
    puts web_images
    return web_images
  end

  def self.getUnusedImages(wiki_content, all_images)
    pos = 0
    uploaded_images = Array.new
    while pos < wiki_content.length do
      # Get file name of the image
      match_data = wiki_content.match(/<img class=\"resize wiki_image\" src=\"\/images\/([^>]+)\" type=\"upload\">/, pos)
      if match_data != nil
        uploaded_images.push(match_data[1])
        pos += wiki_content.index(match_data[0]) + match_data[0].length
      else
        break
      end
    end
    puts "<<<<<<<<<<<<<<<<<<<all uploaded images in wikisource<<<<<<<<<<<<<<"
    puts uploaded_images
    unused_images = all_images.reject {|i| uploaded_images.include? i}
    puts "<<<<<<<<<<<<<<<<<<<<Deleted files<<<<<<<<<<<<<<<<<<<<<<<"
    puts unused_images

    return unused_images
  end
end
