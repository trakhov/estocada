class User < ActiveRecord::Base
	validates :name,	presence: true, length: {maximum: 50}

	VALID_EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, 
										format: { with: VALID_EMAIL_REGEXP },
										uniqueness: { case_sensitive: false }

end
