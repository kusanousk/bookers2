class RelationshipsController < ApplicationController
  def create
    followed_id = params[:relationship][:followed_id]
    current_user.relationships_for_followed.new(followed_id: followed_id).save
    redirect_to user_path User.find(followed_id)
  end

  def destroy
  end
end
