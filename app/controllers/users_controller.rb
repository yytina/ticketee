class UsersController < ApplicationController
  before_action :set_user, only: [:show,
                                  :edit,
                                  :update]
                                  
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)

  	if @user.save
  		flash[:notice] = "You have signed up successfuly."
  		redirect_to projects_path
  	else
      render :new
    end
  end

  def edit
  end

  def update
    
    if @user.update(user_params)
      flash[:notice] = "Profile has been updated."
      redirect_to projects_path
    else
      flash[:alert]="Profile has not been updated."
      render "edit"
    end
  end

  def show
  end

  private
    def user_params
    	params.require(:user).permit(:name, 
    															 :password,
    															 :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The user you were looking" +
                      " for could not be found."
      redirect_to projects_path
    end
end
