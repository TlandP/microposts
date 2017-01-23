class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  @@count_followings = 0
  @@count_followers = 0

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end


# http://servername/users/2/edit
  def edit
    @user = User.find(params[:id])
    check_user(@user)
  end

# http://servername/users/2 method put patch
  def update
    @user = User.find(params[:id])
    check_user(@user)
    if (@user.update(user_profile))
      redirect_to @user # /user/:id/show
    else
      flash[:alert] = "update failed"
      render :edit
    end
    
  end
  

  def followings
    @user = User.find(params[:id])
    @followings = @user.following_users
    @@count_followings += 1
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.follower_users
    @@count_followers += 1
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_profile
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :region)
  end
  
  def check_user(user)
    if (current_user != user)
      redirect_to root_path
    end
  end

end
