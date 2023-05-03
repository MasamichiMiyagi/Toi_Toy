class Public::GamesController < ApplicationController
  before_action :is_matching_login_customer, only: [:edit, :update] #ensure_correct と同じ動作
  before_action :set_q, only: [:index, :search]

  def new
    @game = Game.new
  end

  def index
    @games = Game.all.page(params[:page]).per(7)
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
      @games = Game.all.page(params[:page]).per(7)
      @customer = current_customer
      @q = Game.ransack(params[:q])
      render :index
    end
  end

  def show
    @game_new = Game.new
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
    redirect_to games_path, notice: "You have destroyed successfully."
  end

  def search
    @games = Game.all.page(params[:page]).per(7)
    @game = Game.new
    @results = @q.result
  end

  def player_search
    @games = Game.where('player LIKE ?', "%#{params[:player]}%").page(params[:page]).per(7)
    @game = Game.new
    @q = Game.ransack(params[:q])
    render :index
  end

  def play_time_search
    @games = Game.where('play_time LIKE ?', "%#{params[:play_time]}%").page(params[:page]).per(7)
    @game = Game.new
    @q = Game.ransack(params[:q])
    render :index
  end

  private #←一種の境界線、「ここから下はこのcontrollerの中でしか呼び出せません」という意味があるので、他アクション(create,index,show等)を巻き込まないように一番下に書く。
  #↓以下ストロングパラメータ
  def game_params
    params.require(:game).permit(:title, :body, :game_image, :star, :player, :play_time)
  end

  #ransackを用いた検索機能
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
