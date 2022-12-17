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

  has_one_attached :profile_image

  def get_profile_image(width,height)
    (profile_image.attached?) ? profile_image : 'default_image.jpg'
  end

  def active_for_authentication?
    super && (is_deleted != true)
  end
end
