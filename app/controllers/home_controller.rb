class HomeController < ApplicationController
  def index
  	session[:seme] = nil
  	session[:uke] = nil
  	session[:new_chara_name] = nil
    @newest = Cp.get_newest
    @hottest = Cp.get_hottest
    @newest_seme = Array.new
    @newest_uke = Array.new
    @hottest_seme = Array.new
    @hottest_uke = Array.new
    for cp in @newest
      @newest_seme.push(cp.seme.name)
      @newest_uke.push(cp.uke.name)
    end
    for cp in @hottest
      @hottest_seme.push(cp.seme.name)
      @hottest_uke.push(cp.uke.name)
    end
  end

  def search
  	@characters = Character.search(params[:query])
  	@cps = Cp.search_by_acronym(params[:query]) 
  end

  def search_by_seme_uke
    @cps = Cp.search_by_seme_uke(params[:seme], params[:uke])
  end
end