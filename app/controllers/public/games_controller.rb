class Public::GamesController < ApplicationController
  before_action :is_matching_login_customer, only: [:edit, :update]
  before_action :set_q, only: [:index, :search]

  def new
    @game = Game.new
  end

  def index
    @games = Game.all.page(params[:page]).per(5)
    @game = Game.new
    @customers = Customer.all
    @customer = current_customer
  end

  def create
    @game = Game.new(game_params)
    @game.customer_id = current_customer.id
    if @game.save
      redirect_to game_path(@game), notice: "You have created successfully."
    else
      @games = Game.all
      @customer = current_customer
      render :index
    end
  end

  def show
    @game = Game.find(params[:id])
    @customer = @game.customer
    @post_comment = PostComment.new
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update(game_params)
      redirect_to game_path(@game.id), notice: "You have updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @games = Game.all
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to games_path
  end

  def search
    @results = @q.result
  end

  private #←一種の境界線、「ここから下はこのcontrollerの中でしか呼び出せません」という意味があるので、他アクション(create,index,show等)を巻き込まないように一番下に書く。
  #↓以下ストロングパラメータ
  def game_params
    params.require(:game).permit(:title, :body, :game_image, :star)
  end

  def set_q
    @q = Game.ransack(params[:q])
  end

  def is_matching_login_customer
    game = Game.find(params[:id])
    login_customer_id = current_customer.id
    if(game.customer_id != login_customer_id)
      redirect_to games_path
    end
  end
end
