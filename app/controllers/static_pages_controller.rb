class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
      @micropost = current_user.microposts.build
    end
  end
end
