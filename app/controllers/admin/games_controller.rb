class Admin::GamesController < ApplicationController

  def index
    @games = Game.all.page(params[:page]).per(10)
  end

  def destroy
    @games = Game.all
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to admin_games_path
  end

  private

  def game_params
    params.require(:game).permit(:title, :body, :game_image, :star, :player, :play_time)
  end
end
