class Game < ApplicationRecord

  #アソシエーションの設定
  belongs_to :customer
  has_many :post_comments, dependent: :destroy

  #バリデーションの設定
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  has_one_attached :game_image

  def get_game_image(width, height)
  unless game_image.attached?
    file_path = Rails.root.join('app/assets/images/default-image.jpeg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
    image.variant(resize_to_fit: [width, height]).processed
  end

end
