#!/bin/env ruby
# encoding: utf-8

class CategoriesController < ApplicationController
	def show
		@category_id = ["0", "1", "2", "3", "4"]
		if @category_id.include?params[:id]
			@cps = Cp.find_all_by_category(params[:id])
		else
			redirect_to :controller => :home
		end
	end

end