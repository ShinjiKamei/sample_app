class User < ActiveRecord::Base
  
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", 
                           class_name: "Relationship", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships
  
  
  # ページあたりの表示件数。
  self.per_page = 10
  
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  #↑1字以上の英数字 "-"or"." @ 1字以上の英数字or"-" 0字以上の("."or1字以上の英字) "." 1字以上の英字
  
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  
  validates(:name,  presence: true, length: { maximum: 50 })
  validates(:email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false} )
  validates(:password, presence: true, length: { minimum: 6 })
  validates(:password_confirmation, presence: true)
  
  has_secure_password
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def feed
    #microposts
    #Micropost.where("user_id = ?", id)
    Micropost.from_users_followed_by(self)
  end
  
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end
  
  def follow!(other_user)
    self.relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end
  
  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
