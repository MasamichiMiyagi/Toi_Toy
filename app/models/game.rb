class Game < ApplicationRecord

  #アソシエーションの設定
  belongs_to :customer
  has_many :post_comments, dependent: :destroy

  #バリデーションの設定
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  validates :star,presence:true

  #enum player: { "1~2人": 1, "3~6人": 2, "7人~": 3 } 時間が確保できればinteger型に変更した上でymlファイルで日本語化対応させる。" "内を整数値に置換。

  has_one_attached :game_image

  def get_game_image(width, height)
    unless game_image.attached?
      file_path = Rails.root.join('app/assets/images/default_image.jpeg')
      game_image.attach(io: File.open(file_path), filename: 'default_image.jpeg', content_type: 'image/jpeg')
    end
    game_image.variant(resize_to_limit: [width, height]).processed
  end

end