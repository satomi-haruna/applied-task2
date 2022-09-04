class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    # comment = BookComment.new(book_comment_params)  上は下の2行をまとめた1文
    # comment.user_id = current_user.id
    comment.book_id = book.id
    comment.save
    redirect_back(fallback_location: root_path)
    # バリデーションつける際に使用 ↓
    # else
    #   render 'books/show'
    # end
  end

  def destroy
    BookComment.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end


  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
