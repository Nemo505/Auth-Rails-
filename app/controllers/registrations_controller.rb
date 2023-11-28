class RegistrationsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(registration_params)
        if @user.save
            # Handle successful save (e.g., Redirect to the root path (home page))
            login @user
            redirect_to root_path
        else
            # Handle validation errors or other issues
            render :register, status: :unprocessable_entity
        end
    end

    private
    #function under private cannot be called from outside of controller

    def registration_params
        #params = requested data, .require = check if :user exist, .permist = allow attribute of user to assign
        params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
    end
end