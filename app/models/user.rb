class User < ActiveRecord::Base
	before_save { self.email.downcase! }
	before_create :create_remember_token

	VALID_EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	VALID_NAME_REGEXP = /\A[А-Я][а-я]+\s[А-Я][а-я]+(?:\s[А-Я][а-я]+)?\z/

	validates :name,	presence: true, 
										length: {maximum: 50},
										format: { with: VALID_NAME_REGEXP }

	validates :email, presence: true, 
										format: { with: VALID_EMAIL_REGEXP },
										uniqueness: true #{ case_sensitive: false }

	validates :password, length: {minimum: 6}

	has_secure_password

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
	
end
