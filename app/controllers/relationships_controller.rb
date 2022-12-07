class RelationshipsController < ApplicationController
  
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
  
  # フォローの一覧表示で使うメソッド
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end
  
  # フォロワーの一覧表示で使うメソッド
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
  
end
