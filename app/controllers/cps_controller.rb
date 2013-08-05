class CpsController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def new
    @cp = Cp.new
    @character1 = Character.find_by_id(5)
    @character2 = Character.find_by_id(6)
  end

  def create

    @cp = Cp.new(:category => params[:category], 
                 :summary => params[:summary], 
                 :wiki_content => params[:wiki_content],
                 :character1_id => params[:seme],
                 :character2_id => params[:uke],
                 :creator_id => current_user.id,
                 :created_at => Time.now)
    @cp.save

    @relation = Relation.new(:cp_id => @cp.id,
                             :acronym => params[:acronym], 
                             :intro => params[:intro])
    # check type, a x b or b x a
    # now set to 1 first
    @relation.type = 1

    if @relation.save
      p "everyting saved!"
      redirect_to :controller => :cps, :action => :new
    else
      p "something wrong"
      render :action => new
    end
  end

end