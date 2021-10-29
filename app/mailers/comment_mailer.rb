class CommentMailer < ApplicationMailer

    #when theres a new comment created, send an email to the author of the comment
    def new_comment(author, comment)
        #after it figures out these details, the body of the email is going to be rendered by the view. So, we want to render the contents comment.
        @comment = comment
        #the from address has enough data encoded in it so we can directly reply to it and store it as a child of this comment id. 
        mail(
            to: author.email,
            from: "comment-#{@comment.id}@reply.example.com",
            subject: "New comment on your post"
        )
    end
end
