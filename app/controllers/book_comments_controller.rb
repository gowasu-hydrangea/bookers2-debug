class BookCommentsController < ApplicationController
  
  # ア・２＞18章
  # コメント機能の実装
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_to book_path(book)
  end
  
  def destroy
  end
  
  private
  
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end


end