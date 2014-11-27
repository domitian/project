class UsersController < ApplicationController
  def new
	@user=User.new
	@dept=Department.all
	@role=Role.all
  end
  def show
  @user=User.find(params[:id])
  @dept=Department.all	  
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

  private
  def user_params
	params.require(:user).permit(:name,:email,:password,:password_confirmation,:department_id,:role_id)
  end

end
