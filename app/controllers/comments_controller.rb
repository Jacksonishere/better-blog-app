class CommentsController < ApplicationController
    def create
        #create comment for the post from the current user
        #now this is good since we're establishing the connection between the comment and the current user making it, but what about the association from the comment to the post. Merge the id of the current post to the params. 
        @comment = current_user.comments.build(comments_params)
        #if comment doesnt save, set the flash message in which you set flash[:notice] when you're about to go to another request and u need the message to persist, versus if you do flash.now[:notice] is usually when youre gonna render another page
        if @comment.save
            #author of the post should be notified if new comment made
            post_author = @comment.post.user

            #SEND EMAIL TO THE AUTHOR OF POST
            #dont send an email to the user who made the post and commented under it. 
            if post_author != @comment.user
                CommentMailer.new_comment(post_author, @comment).deliver_now
            end
            #SEND EMAIL TO THE PERSON WHOSE COMMENT YOU'RE REPLYING TO IF SUCH A THING
            if !@comment.parent_id.nil?
                parent_comment_author = @comment.parent.user
                if parent_comment_author != post_author && parent_comment_author != @comment.user
                    CommentMailer.new_comment(parent_comment_author, @comment).deliver_now
                end
            end

            flash[:notice] = "Comment added"
        else 
            flash[:notice] = @comment.errors.full_messages.to_sentence
        end
        
        #we want to redirect back to the post but with a success message
        redirect_to post_path(params[:post_id])
    end

    private

    def comments_params
        #remember, the id of the post is included in the params beucase we nested the comments route with the post we're currently showing which contains the id of post.
        params.require(:comment).permit(:content, :parent_id).merge(post_id: params[:post_id])
    end

end
