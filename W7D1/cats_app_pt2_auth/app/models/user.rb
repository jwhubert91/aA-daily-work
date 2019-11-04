# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
    attr_reader :password

    after_initialize :ensure_session_token

    validates :user_name, presence: true, uniqueness: true
    validates :password_digest, presence: { message: "password can't be blank" }
    validates :password, length: { minimum: 5, allow_nil: true }
    validates :session_token, { presence: true }

    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def self.find_by_credentials(username,password)
        user = User.find_by(user_name: username)
        if user == nil # no user is found with user_name = username
            return nil # we cannot look for password match
        else # user exists
            user.is_password?(password) ? user : nil # verify password matches
        end
    end

    def reset_session_token!
        self.session_token = self.class.generate_session_token
        self.save!
        self.session_token
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    private
    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end
end
