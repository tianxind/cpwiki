class CpsController < ApplicationController
  #before_filter :authenticate_user!

  def index
  end

  def new
    @photo = Photo.new
    @cp = Cp.new
    @character1 = Character.find_by_id(session[:id1])
    @character2 = Character.find_by_id(session[:id2])
  end

  def create
    puts "<<<<<<<<<<<<<<<<What are the params?"
    puts params
    @cp = Cp.new(:category => params[:category], 
                 :summary => params[:summary], 
                 :wiki_content => params[:wiki_content],
                 :character1_id => params[:seme],
                 :character2_id => params[:uke],
                 :creator_id => current_user.id)

    if !@cp.save then
      render :action => :new
    end
    
    # relation type is set to 0 if character1 x character2,
    # 1 if character2 x character1
    @relation = Relation.new(:cp_id => @cp.id,
                             :acronym => params[:acronym], 
                             :intro => params[:intro],
                             :relation_type => params[:relation_type])
  
    if @relation.save
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
    deleted_files = params[:images].reject(|i| files.include? i)
    puts "<<<<<<<<<<<<<<<<<<<<Deleted files<<<<<<<<<<<<<<<<<<<<<<<"
    puts deleted_files
    # Delete all entries from database and the files on our server
    deleted_files.each do |f|
      image = Photo.find_by_filename(f)
      image.destroy
      File.delete(Rails.root.join('public', 'images', image.filename))
    end
  end
  
  def show
    @cp = Cp.find_by_id(params[:id])
    @character1 = @cp.character1
    @character2 = @cp.character2
    @comment_array = @cp.comments
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
    @character1 = Character.search(params[:name1])
    @character2 = Character.search(params[:name2])
  end
  
  def redirect_to_cp_or_character
    session[:id1] = params[:character1]
    session[:id2] = params[:character2]
    if session[:id1] != "nil" && session[:id2] != "nil"
      cp = Cp.find(:all, :conditions => {:character1_id => session[:id1], :character2_id => session[:id2]})
      if cp == nil
        cp = Cp.find(:all, :conditions => {:character1_id => session[:id2], :character2_id => session[:id1]})
      end
      if cp.length > 0
        redirect_to :action => :show, :id => cp[0].id
      else
        redirect_to :action => :new
      end
    else
      redirect_to :controller => :characters, :action => :new
    end
  end
end

