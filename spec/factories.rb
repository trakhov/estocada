FactoryGirl.define do
	factory :user do
		name 'Егор Сергеев'
		email 'foo@bar.ch'
		password 'foobarr'
		password_confirmation 'foobarr'
	end
end