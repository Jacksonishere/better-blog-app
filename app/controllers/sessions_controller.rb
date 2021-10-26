class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    #attempt login and create session.
    def create
        #lookup the user in db by email 
        @user = User.find_by(email: user_params[:email])
        
        #if user exists and the raw password is equal to the users password, password_digest
        if @user&.is_password?(user_params[:password])
            #store the user_id in the session
            session[:user_id] = @user.id
            redirect_to posts_path
        else
            #invalid credentials. render new again
            flash.now[:notice] = "Invalid email or password"
            render :new
        end
    end

    #destroy session, 
    def destroy
        session[:user_id] = nil
        #if you dont redirect, its going to appear as if you're still signed in, until you make another request. you dont just want to render :new
        redirect_to sign_in_path
    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end
