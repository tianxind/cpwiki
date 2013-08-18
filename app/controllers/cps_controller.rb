class CpsController < ApplicationController
  #before_filter :authenticate_user!

  def index
  end

  def new
    @photo = Photo.new
    @cp = Cp.new
    @seme = Character.find_by_id(session[:seme])
    @uke = Character.find_by_id(session[:uke])
    p "session id seme, uke are "
    p session[:seme]
    p session[:uke]
  end

  def create
    puts "<<<<<<<<<<<<<<<<What are the params?"
    puts params
    @cp = Cp.new(:category => params[:category], 
                 :summary => params[:summary], 
                 :wiki_content => params[:wiki_content],
                 :seme_id => session[:seme],
                 :uke_id => session[:uke],
                 :creator_id => current_user.id,
                 :acronym => params[:acronym],
                 :created_at => Time.now)
  
    if @cp.save
      session[:seme] = nil
      session[:uke] = nil
      session[:name1] = nil
      session[:name2] = nil
      redirect_to :controller => :cps, :action => :show, :id => @cp.id
    else
      render :action => :new
    end
    
    # See if there is any image we need to delete
    pos = 0
    wiki_content = params[:wiki_content]
    files = Array.new
    while pos < wiki_content.length do
      # Get file name of the image
      match_data = wiki_content.match(/<img(.+)src=\"(.+)\">/, pos)
      if match_data != nil
        files.push(match_data[2])
        pos += 4
      else
        break
      end
    end
    # deleted_files = params[:images].reject(|i| files.include? i)
    # puts "<<<<<<<<<<<<<<<<<<<<Deleted files<<<<<<<<<<<<<<<<<<<<<<<"
    # puts deleted_files
    # Delete all entries from database and the files on our server
    # deleted_files.each do |f|
    #  image = Photo.find_by_filename(f)
    #  image.destroy
    #  File.delete(Rails.root.join('public', 'images', image.filename))
    # end
  end
  
  def show
    @cp = Cp.find_by_id(params[:id])
    @seme = Character.find_by_id(@cp.seme_id)
    @uke = Character.find_by_id(@cp.uke_id)
    @comment_array = @cp.comments
    @already_liked = (Like.find_by_sql("SELECT * from likes WHERE user_id=" + current_user.id.to_s + " AND cp_id=" + params[:id].to_s)).size
    p "already_liked size is >>>>>>>>"
    p @already_liked
    p "comment array is ->>>>>>"
    p @comment_array
  end

  # def addComment
  #   @cp = Cp.find_by_id(params[:id])
  #   @comment = Comment.new(:cp_id => @cp.id,
  #                          :user_id => current_user.id,
  #                          :comment_text => params[:comment])
  #   if !@comment.save
  #     p ">>>>>>>>> comment saving failed"
  #   else 
  #     p ">>>>>>>>> save succeed!"
  #   end
  # end

  def choose 
  end
  
  def search
    session[:category] = params[:category]
    params[:name1].strip!
    params[:name2].strip!
    session[:name1] = params[:name1]
    session[:name2] = params[:name2]

    p "in seach func session name1 and name 2 are"
    p session[:name1]
    p session[:name2]
    @character1 = Character.search(params[:name1])
    @character2 = Character.search(params[:name2])
  end
  
  def redirect_to_cp_or_character
    session[:seme] = params[:character1]
    session[:uke] = params[:character2]
    puts "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    puts "semd_id = #{session[:seme]}"
    puts "uke_id = #{session[:uke]}"
    if session[:seme] != "nil" && session[:uke] != "nil"
      cp = Cp.find(:all, :conditions => {:seme_id => session[:seme], :uke_id => session[:uke]})
      if cp.length > 0
        p "cp length > 0"
        redirect_to :action => :show, :id => cp[0].id
      else
        p "cp not exist"
        redirect_to :action => :new
      end
    else
      p "redirect to chara/new"
      redirect_to :controller => :characters, :action => :new
    end
  end
end

