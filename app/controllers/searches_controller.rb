class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    # 検索結果表示の画面で使用するには、変数変換して使用する
    @word = params[:word]

    if @range == "User"
      # ifで1つ目のプルダウンの選択結果からの分岐
      # 検索wordを、どんな感じ(完全・部分)でもってくるか指定 → モデル内での検索結果を変数へ代入
      @users = User.looks(params[:search], params[:word])
    else
      @books = Book.looks(params[:search], params[:word])
    end
  end


end
