# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
    games_path
  end

  # POST /resource/sign_in
  def create
    if super
      games_path
    else
      #ログイン画面に何も記載しなかった際に、リンクが読み込まれてしまうことがないようにrender先を指定
      render new_customer_session_path
    end
  end

  # DELETE /resource/sign_out
  def destroy
    if super
      root_path
    else
      render customer_path(current_customer)
    end
  end

  protected
  # 退会しているかを判断するメソッド
  def configure_sign_in_params
    # 入力されたemailからアカウントを1件取得
    @customer = Customer.find_by(email: params[:customer][:email])
    # アカウントを取得できなかった場合、このメソッドを終了する
    return if !@customer
    # 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @customer.valid_password?(params[:customer][:password]) && (@customer.is_deleted == true)
      redirect_to new_customer_registration_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
