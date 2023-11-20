class SessionsController < ApplicationController
  def new

  end

  def create
    if user = User.authenticate_by(email: params[:email], password: params[:password])
      login user
      redirect_to root_path, notice: "You have logged in successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
  end
end
