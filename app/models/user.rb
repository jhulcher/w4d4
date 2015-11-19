class User < ActiveRecord::Base

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
    self.password_digest = BCrypt::Password.create(password)
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
