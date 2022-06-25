class SearchsController < ApplicationController
  def search
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
