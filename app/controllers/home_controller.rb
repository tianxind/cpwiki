class HomeController < ApplicationController
  def index
  	session[:seme] = nil
  	session[:uke] = nil
  	session[:new_chara_name] = nil
    @newest = Cp.get_newest
    @seme = Array.new
    @uke = Array.new
    for cp in @newest
      puts "<<<<<<<<<<<<<<<<<<" + cp.id.to_s
      @seme.push(cp.seme.name)
      @uke.push(cp.uke.name)
    end
  end

  def search
  	@characters = Character.search(params[:query])
  	@cps = Cp.search_by_acronym(params[:query]) + Cp.search_cps_by_chara(params[:query])
  end

  def search_by_seme_uke
    @cps = Cp.search_by_seme_uke(params[:seme], params[:uke])
  end
end