class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}


  # ログイン中のユーザーがその投稿に対していいねをしているか、を判断
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
