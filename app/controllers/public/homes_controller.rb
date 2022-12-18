class Public::HomesController < ApplicationController

  def top
  end

  #ゲストログイン機能
  def guest_sign_in
    customer = Customer.find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "Guest"
      # user.skip_confirmation!  # Confirmable を使用している場合は必要
    end
    sign_in customer
    redirect_to games_path, notice: 'ゲストユーザーとしてログインしました。'
  end

end
