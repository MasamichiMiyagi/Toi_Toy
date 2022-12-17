class Admin::GamesController < ApplicationController

  def index
    @games = Game.all
    @game = Game.new
    @customers = Customer.all
    @customer = Customer.find(params[:customer_id])
  end

  def show
    @game = Game.find(params[:id])
    @customer = @game.customer
    @post_comment = PostComment.new
  end

  def edit
    @game = Game.find(params[:id])
  end

  def destroy
    @games = Game.all
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to games_path
  end

  private #←一種の境界線、「ここから下はこのcontrollerの中でしか呼び出せません」という意味があるので、他アクション(create,index,show等)を巻き込まないように一番下に書く。
  #↓以下ストロングパラメータ
  def game_params
    params.require(:game).permit(:title, :body, :game_image)
  end
end
