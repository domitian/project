class SessionsController < ApplicationController
  def new
  end
  
  def create
      	user=User.find_by(email: params[:session][:email].downcase)
	if user && user.authenticate(params[:session][:password])
	   log_in user	
      	    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
	   #remember user
	   redirect_to user	
	#log the user in and redirect to user's show page
	else	
	flash.now[:danger]='Invalid email/password combination' #Not quite right!!
   	 render 'new'
	end
   end
  def destroy
     log_out if logged_in?
    redirect_to root_url
  end
end