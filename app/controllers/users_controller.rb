class UsersController < ApplicationController
  before_action :set_user, only: %i( show create edit update destroy)

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user.save
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Image was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    ActiveStorage::Attachment.all.each { |attachment| attachment.purge }
    redirect_to user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, photos: [])
  end

end
