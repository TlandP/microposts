class UseController < ApplicationController
  def new
    @user = User.new
  end
end
