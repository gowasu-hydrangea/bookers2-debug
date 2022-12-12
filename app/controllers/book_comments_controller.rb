class BookCommentsController < ApplicationController
  
  # ア・２＞18章
  # コメント機能の実装
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    @books=Book.find(params[:book_id])
    @book_comment = BookComment.new
    # redirect_to book_path(book)
  end
  
  def destroy
    # BookComment.find(params[:id]).destroy
    # redirect_to book_path(params[:book_id])
    @books=Book.find(params[:book_id])
    @book_comment=BookComment.find_by(id: params[:id], book_id: params[:book_id])
    @book_comment.destroy
    @book_comment = BookComment.new
  end
  
  private
  
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end


end
