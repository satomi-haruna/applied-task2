class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    # comment = BookComment.new(book_comment_params)  上は下の2行をまとめた1文
    # comment.user_id = current_user.id
    comment.book_id = book.id
    comment.save
    # 非同期通信化のためにredict先を変更
    # redirect_back(fallback_location: root_path)
    # render :book_comments
    # バリデーションつける際に使用 ↓
    # else
      # render 'books/show'
    # end
  end

  def destroy
    BookComment.find(params[:id]).destroy
    # 非同期通信化のためにredirect先を変更
    # redirect_back(fallback_location: root_path)
    @book = Book.find(params[:book_id])
    # render :book_comments
  end


  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
