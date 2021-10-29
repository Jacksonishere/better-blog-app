class LikesController < ApplicationController
    def create
        @like = current_user.likes.build(like_params)
        if !@like.save
            flash[:notice] = @like.errors.full_messages.to_sentence
        end

        #for other models that use likes like comment, there is no show route so its gonna through error. redirect back instead
        # redirect_to @like.likeable
        redirect_back(fallback_location: posts_url);
    end

    def destroy
        @like = current_user.likes.find(params[:id])
        likeable = @like.likeable
        @like.destroy
        
        # redirect_to likeable
        redirect_back(fallback_location: posts_url);
    end

    private

    def like_params
        params.require(:like).permit(:likeable_id, :likeable_type)
    end
end
