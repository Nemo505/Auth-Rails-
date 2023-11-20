class ApplicationController < ActionController::Base

    private

    # If Current.user is already set Otherwise, it calls authenticate_user_from_session to look up the user from the session 
    # and sets Current.user accordingly.
    def current_user
      Current.user ||= authenticate_user_from_session
    end
    helper_method :current_user
    
    def authenticate_user_from_session
      User.find_by(id: session[:user_id])
    end

    def user_signed_in?
        #present return true if current_user exist
      current_user.present?
    end

    #o make the method accessible across all controllers and views.
    helper_method :user_signed_in?

    def login(user)
      Current.user = user
      reset_session
      # any old session data is discarded when a user logs in
      session[:user_id] = user.id
    end

    def logout(user)
        Current.user = nil
        reset_session
    end
end
