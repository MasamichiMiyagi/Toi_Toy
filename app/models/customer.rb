class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #アソシエーションの設定(dependentを用いて、1:Nの1側が削除されたとき、N側を全て削除する)
  has_many :games, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  #バリデーションの設定
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true

  #以下画像読み込みに関する処理
  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/profile_icon.png')
      profile_image.attach(io: File.open(file_path), filename: 'profile_icon.png', content_type: 'image/png')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def active_for_authentication?
    super && (is_deleted != true)
  end
end
