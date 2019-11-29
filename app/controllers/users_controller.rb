class UsersController < ApplicationController
  before_action :set_user, only:[:edit,:update,:destroy]

  def index
    @search_params = user_search_params
    @users = User.search(@search_params).includes(:prefecture)
  end

  def new
    @user = User.new
    @prefectures = Prefecture.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name,:gender,:birthday,:prefecture_id,tag_ids:[])
  end

  def user_search_params
    params.fetch(:search, {}).permit(:name, :gender, :birthday_from, :birthday_to, :prefecture_id, tag_ids:[])
  end
end
