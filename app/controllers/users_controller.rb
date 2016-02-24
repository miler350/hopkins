class UsersController < ApplicationController
  
  def index
    load_users
  end
  
  def new
    build_user
  end
  
  def create
    build_user
    login_user or render 'new'
  end
  
  def show
    load_user
  end

  def edit
    load_user
    build_user
  end
  
  def update
    load_user
    build_user
    save_user or render 'edit'
  end
  
  def destroy
    
    
  end
  
  private
  
  def load_users
    @users ||= user_scope.to_a
  end
  
  def load_user
    current_user
  end
  
  def login_user
    if @user.save!
      cookies.permanent[:authentication_token] = @user.authentication_token
      redirect_to surveys_path
    end
  end
  
  def build_user
    @user ||= User.new(user_params)
  end
  
  def save_user
    if @user.save
      redirect_to surveys_path
    end
  end
  
  def user_params
    user_params = params[:user]
    user_params ? user_params.permit(:first_name, :last_name, :email, :city, :state, :education, :terms, :password, :password_confirmation) : {}
  end
  
  def user_scope
    User.scoped
  end
  
end
