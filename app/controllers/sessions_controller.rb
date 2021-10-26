class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        #lookup the user in db by email 
        @user = User.find_by(email: user_params[:email])
        
        #if user exists and password matches
        if @user && @user.password == user_params[:password]
            #store the user_id in the session
            session[:user_id] = @user.id
            redirect_to posts_path
        else
            flash.now[:notice] = "Invalid email or password"
            render :new
        end

    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end
