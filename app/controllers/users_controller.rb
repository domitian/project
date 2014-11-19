class UsersController < ApplicationController
  def new
	@user=User.new
  end
  def show
  @user=User.find(params[:id])
  
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
	params.require(:user).permit(:name,:email,:role,:password,:password_confirmation)
  end

end
