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

  # フォロー一覧のため userモデルの定義より:following_user
  def follows
    user = User.find(params[:user_id])
    @users = user.following_user
  end
  # フォロワー一覧のため userモデルの定義より:follower_user
  def followers
    user = User.find(params[:user_id])
    @users = user.follower_user
  end

end
