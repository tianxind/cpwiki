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

  def self.deleteUnusedImages(wiki_content, all_images)
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

  def getAllWebImages(wiki_content)
    pos = 0
    files = Array.new
    while pos < wiki_content.length do
      # Get file name of the image
      match_data = wiki_content.match(/<img(.+)type=\"(.+)\"(.+)src=\"\/images\/(.+)\">/, pos)
      if match_data != nil
        files.push(match_data[4])
        pos += 4
      else
        break
      end
    end
    puts "<<<<<<<<<<<<<<<<<<All Web Images<<<<<<<<<<<<<"
    puts files
    return files 
  end

  def self.saveAllWebImages(wiki_content)
    images = getAllWebImages(wiki_content)
    for image in images
      @photo = Photo.new
      @photo.user_id = current_user.id
      @photo.filename = image
      @photo.date_time = DateTime.now
      @photo.save
    end
  end
end
