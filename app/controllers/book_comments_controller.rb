class BookCommentsController < ApplicationController
  before_action :ensure_correct_user, only: [:destroy]

  def create
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.new(book_comment_params)
    @book_comment.user_id = current_user.id
    @book_comment.save
  end

  def destroy
    BookComment.find(params[:id]).destroy
    redirect_back fallback_location: books_path
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  def ensure_correct_user
    book_comment = BookComment.find(params[:id])
    unless book_comment.user == current_user
      redirect_to book_path(book_comment.book)
    end
  end
end
