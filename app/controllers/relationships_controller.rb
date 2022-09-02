class RelationshipsController < ApplicationController

  # フォローする createアクション
  def follow
    current_user.follow(params[:id])
    redirect_back(fallback_location: root_path)
  end

  # フォローを外す destroyアクション
  def unfollow
    current_user.unfollow(params[:id])
    redirect_back(fallback_location: root_path)
  end


end
