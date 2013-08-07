class UsersController < ApplicationController
  before_action :signed_in_user, except: [:new, :create]
  before_action :correct_user, except: [:new, :create]

  def new
  	@user = User.new
  end

  def show
  	@user = User.find params[:id]
  end

  def create
  	@user = User.new user_params 
  	if @user.save
      sign_in @user
      flash[:success] = "Добро пожаловать, #{@user.name}!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit 
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update user_params
      flash[:success] = 'Изменения успешно сохранены'
      sign_in @user
      redirect_to @user
    else
      flash[:error] = 'Проверьте введенные данные'
      render :edit
    end
  end


  private 

    def user_params
      params.require(:user).permit(:name, 
        :email, :password, :password_confirmation,
        :avatar, :tempfile, :avatar_file_name)
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: 'Войдите, чтобы продолжить'
      end
    end

    def correct_user
      @user = User.find params[:id]
      redirect_to root_url unless @user == current_user
    end



end
