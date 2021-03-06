# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'securerandom'

class User < ApplicationRecord
    
  attr_reader :password
  after_initialize :ensure_session_token

  validates :username, presence: true, uniqueness: true
  validates :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_many :goals,
    foreign_key: :author_id

  has_many :comments,
    foreign_key: :author_id

  has_many :commented_goals,
    through: :goals,
    source: :comments

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user && user.is_password?(password)
    user
  end
  
  def password=(password)
      @password = password 
      self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    bcrypt_password = BCrypt::Password.new(self.password_digest)
    bcrypt_password.is_password?(password)
  end
  
  def self.generate_session_token
      SecureRandom::urlsafe_base64
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
