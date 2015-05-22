class User < ActiveRecord::Base
  
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  #↑1字以上の英数字 "-"or"." @ 1字以上の英数字or"-" 0字以上の("."or1字以上の英字) "." 1字以上の英字
  
  #before_save { self.email = email.downcase }
  before_save { email.downcase! }
  
  validates(:name,  presence: true, length: { maximum: 50 })
  validates(:email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false} )
  validates(:password, presence: true, length: { minimum: 6 })
  validates(:password_confirmation, presence: true)
  
  has_secure_password

end
