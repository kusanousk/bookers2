class SearchsController < ApplicationController
  def search
    return book_tag_search(params[:tag]) if params.has_key?(:tag)

    @target = params[:target]

    case @target
    when "user"
      @items = User.where("name LIKE ?", like(params[:word], params[:type]))
    when "book"
      @items = Book.where("title LIKE ?", like(params[:word], params[:type]))
    else
      not_found
    end
  end

  private

  def book_tag_search(tag)
    @target = "book"
    @items = Book.where(tag: params[:tag])
  end

  def like(word, type)
    case type
    when "perfect"
      return word
    when "forward"
      return "#{word}%"
    when "backward"
      return "%#{word}"
    when "partial"
      return "%#{word}%"
    else
      not_found
    end
  end
end
