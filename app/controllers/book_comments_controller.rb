class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_new_params)
    # comment = Book.new(book_comment_params)  上は下の2行をまとめた1文
    # comment.user_id = current_user.id
    comment.book_id = book.id
    comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    BookComment.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end


  private

  def book_params
    params.require(:book).permit(:comment)
  end

end
