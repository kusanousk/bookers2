class RelationshipsController < ApplicationController
  before_action :ensure_correct_user, only: [:destroy]

  def create
    followed_id = params[:relationship][:followed_id]
    current_user.relationships_for_followed.new(followed_id: followed_id).save
    redirect_to user_path User.find(followed_id)
  end

  def destroy
    relationship = Relationship.find(params[:id])
    relationship.destroy
    redirect_to user_path relationship.follow
  end

  private

  def ensure_correct_user
    relationship = Relationship.find(params[:id])
    unless relationship.follower == current_user
      redirect_to user_path(relationship.follow)
    end
  end
end
