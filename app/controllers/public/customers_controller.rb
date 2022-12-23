class Public::CustomersController < ApplicationController
  before_action :ensure_correct_customer, only: [:update]

  def index
    @game = Game.new
    @customers = Customer.all.page(params[:page]).per(7)
    @customer = current_customer
  end

  def show
    @customer = Customer.find(params[:id])
    @games = @customer.games
    @game = Game.new
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customers_path(@customer), notice: "You have updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private #←一種の境界線、「ここから下はこのcontrollerの中でしか呼び出せません」という意味があるので、他アクション(create,index,show等)を巻き込まないように一番下に書く。
  #↓以下ストロングパラメータ
  def customer_params
    params.require(:customer).permit(:name, :profile_image)
  end

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end

end
