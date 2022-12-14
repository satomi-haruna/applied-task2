class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :book_comments, dependent: :destroy
  # フォローをした、されたの関係
  #フォローしている人の取得、フォローされている人の取得
  #
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 一覧画面で使うらしい
  # 自分のデータを取得する際のため
  # 自分がフォローしている人、自分をフォローしている人（＝自分がフォローされている）
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum:50 }



  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  # コントローラで使う？
  # フォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  # フォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  # フォローしているか確認
  def following?(user)
    following_user.include?(user)
  end


  # 検索方法の分岐
  def self.looks(search, word)
    if search == "perfect"
      # ユーザー名の参照だからname LIKE、nameカラムこんな？って
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward"
      @user = User.where("name LIKE?", "#{word}%")
    elsif search == "backward"
      @user = User.where("name LIKE?", "%#{word}")
    elsif search == "partial"
      @user = User.where("name LIKE?", "%#{word}%")
    else
      @user = User.all
    end
  end

  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

end
