#before any of the routes get mapped to a controller, it goes to the applicationcontroller first
class ApplicationController < ActionController::Base
    #makes this method usable in views
    helper_method :current_user

    #this is the top of the top for all your web requests and deos the job of passing requests to and from rails routes. 

    #most of the common filters/hooks which are required in every part of your applicaion such as: handling authentication, authorization, etc are defined here as this is the first place that the HTTP request hits on your application before delegating to the specified controller.

    #check who is the current user in the cookies
    #use session which is another tool thats available inside controller which works with encrypted cookies by default.
    def current_user
        #if there is a user_id, aka user, in the session, go find that user
        if session[:user_id]
            User.find(session[:user_id])
        end
    end
    
    #if there isnt a current user, redirect to root path.
    #remember, routes -> controller -> model, so we're able to use the path helpers but also can use the models here as well.
    def require_current_user
        if current_user.nil?
            redirect_to "/"
        end
    end
end
