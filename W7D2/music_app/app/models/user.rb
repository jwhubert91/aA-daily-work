# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
    attr_reader :password

    validates :email, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :session_token, presence: true
    validates :password, length: {minimum: 5, allow_nil: true}

    after_initialize :ensure_session_token

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
