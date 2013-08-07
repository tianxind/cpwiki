class CpsController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def new
    @cp = Cp.new
    @character1 = Character.find_by_id(1)
    @character2 = Character.find_by_id(2)
  end

  def create
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
  end
  
  def show
    @cp = Cp.find_by_id(params[:id])
    @character1 = @cp.character1
    @character2 = @cp.character2
  end

end