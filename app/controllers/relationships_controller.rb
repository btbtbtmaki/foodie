class RelationshipsController < ApplicationController
	
	def create
		user = User.find(params[:followed_id])
		current_user.add_friend(user)
		redirect_to(:back)
	end

	def destroy
		user = Relationship.find(params[:id]).followed
		current_user.remove_friend(user)
		redirect_to(:back)
	end
	
end