class UsersController < ApplicationController
 before_action :logged_in_user, only: [:index,:edit, :update,:destroy]
 before_action :correct_user,   only: [:edit, :update] 
before_action :admin_user,     only: :destroy
  def index
	 @users = User.paginate(page: params[:page])
  end 
  def new
	@user=User.new
	@dept=Department.all
	@role=Role.all
  end
  def show
  	@user=User.find(params[:id])
  	@dept=Department.all	  
  	if params[:department_id]
  		@department = Department.find(params[:deparament_id])
  	end
  end

  def create
	@user=User.new(user_params)
	if @user.save
	      log_in @user
	flash[:success]="welcome to role based accesscontrol mechanism"
	redirect_to @user
	#handle a successful save
	else
	  render 'new'
	end
  end
  def edit 
	@user=User.find(params[:id])
	    if @user.update_attributes(user_params)
      			flash[:success] = "Profile updated"
      			redirect_to @user

    	    else
     		render 'edit'
    	    end
  end

def logged_in_user
      unless logged_in?
	store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end


def correct_user
      @user = User.find(params[:id])
            redirect_to(root_url) unless current_user?(@user)

    end


 def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

 # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end	

  private
  def user_params
	params.require(:user).permit(:name,:email,:password,:password_confirmation,:department_id,:role_id)
  end

end
