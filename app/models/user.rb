class User < ActiveRecord::Base
	before_save { self.email.downcase! }

	validates :name,	presence: true, length: {maximum: 50}

	VALID_EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, 
										format: { with: VALID_EMAIL_REGEXP },
										uniqueness: true #{ case_sensitive: false }

	validates :password, length: {minimum: 6}

	has_secure_password

end
