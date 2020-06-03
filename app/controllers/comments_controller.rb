





class CommentsController < ApplicationController
	before_action :authenticate_user!, only: [:show, :create]

	def create
	 	@book_find = Book.find(params[:book_id])
	 	@comment = Comment.new(comment_params)
        @comment.user_id = current_user.id #誰がコメントしているのか
        @comment.book_id = @book_find.id #どの投稿に対してのコメントか
	 	@comments = Comment.where(book_id: @book_find.id)
	 	if @comment.save
	 	   redirect_to book_path(@book_find.id)
	 	else
	 	   @user = User.find(@book_find.user_id)
	 	   @book = Book.new
           render template: "books/show"
	 	end
	end

	def destroy
		@comment = Comment.find(params[:id])
        if @comment.user_id == current_user.id
           @comment.destroy
	       redirect_to request.referer
        else
           @book_find = Book.find(params[:book_id])
           @user = User.find(@book_find.user_id)
	 	   @book = Book.new
	 	   @comments = @book_find.comments
           render template: "books/show"
	    end
    end

	private
		def comment_params
			params.require(:comment).permit(:comment)
		end
end
