class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email])

    if user && user.authenticate(params[:session][:password])
      # Log in the user and redirect to the desired location
      login user
      redirect_to root_url
    else
      # Display an error message and render the login form again
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    # Log out the user
    logout
    redirect_to root_url, notice: 'Logged out successfully!'
  end
end
