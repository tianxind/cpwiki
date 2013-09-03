class TagsController < ApplicationController
	before_filter :authenticate_user!

	def create
		@tag = Tag.new(:pos_x => params[:xpos],
					   :pos_y => params[:ypos],
					   :comment => params[:comment],
					   :user_id => current_user.id,
					   :photo_id => params[:photo_id],
					   :created_at => Time.now)
		if @tag.save
			render :nothing => true
		end
	end
end