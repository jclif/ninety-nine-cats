class User < ActiveRecord::Base
  attr_accessible :user_name, :password

  attr_reader :password

  before_validation :ensure_session_token

  validates :user_name, :presence => true
  validates :password_digest, :presence => { :message => "Password can't be blank" }
  validates :password, :length => { :minimum => 6, :allow_nil => true }

  def self.find_by_credentials(user_name, password)
    user = User.find_by_user_name(user_name)
    if user.is_password?(password)
      user
    else
      #wrong credentials, try again
    end
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.generate_session_token
      SecureRandom::urlsafe_base64(16)
    end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
