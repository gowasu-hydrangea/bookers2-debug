class SearchesController < ApplicationController
  # ポ・基＞課題５
  # 検索機能の実装
  # 参考元
  # https://qiita.com/hapiblog2020/items/6c2cef49df5616da9ae3
  before_action :authenticate_user!
  
  def search
    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @books = Book.looks(params[:search], params[:word])
    end
  end
  
end
