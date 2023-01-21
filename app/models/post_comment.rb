class PostComment < ApplicationRecord

  belongs_to :customer
  belongs_to :game

  #バリデーションの設定
  validates :comment, presence:true

end
