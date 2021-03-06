class BooksController < ApplicationController
  before_action :ensure_correct_user, only: %i[edit update destroy]

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @book_comment = BookComment.new
  end

  def index
    sort = params.fetch(:sort, "new")
    case sort
    when "new"
      order = { id: "DESC" }
    when "rate"
      order = { rate: "DESC" }
    else
    end

    @books = Book.all.order(order)
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book),
                  notice: "You have created book successfully."
    else
      @books = Book.all
      render "index"
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book),
                  notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :rate, :tag)
  end

  def ensure_correct_user
    book = Book.find(params[:id])
    redirect_to books_path unless book.user == current_user
  end
end
