class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
    render :layout => 'guest_layout' unless current_user
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Welcome {#@user.username}!"
    else
      render :new
    end
  end

  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      redirect_to(login_path, :notice => 'User activated successfully')
    else
      not_authenticated
    end
  end

end
