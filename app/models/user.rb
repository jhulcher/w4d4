class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, :password_digest, :session_token, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}

  attr_reader :password

  after_initialize do
    self.session_token ||= generate_session_token
  end

  def generate_session_token
    self.session_token = SecureRandom.base64(16)
  end

  def reset_session_token!
    generate_session_token
  end

  def password=(password)
    pass = BCrypt::Password.create(password)
    self.password_digest = pass
  end

  def is_password?(password)
    pass = BCrypt::Password.new(self.password_digest)
    pass.is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    user.is_password?(password) ? user : nil
  end

end
