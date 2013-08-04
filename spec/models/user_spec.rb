require 'spec_helper'

describe User do
  
  before { @user = User.new(name: 'Петров Сергей Иванович', 
														email: 'petrov@gmail.com'
														) }

  subject { @user }

  it { should respond_to :name }
  it { should respond_to :email }

  describe 'when name is not present' do
  	before { @user.name = ' ' }
  	it { should be_invalid }
  end

  describe 'when email is not present' do
  	before { @user.email = ' ' }
  	it { should be_invalid }
  end

  describe 'when user name is too long' do
  	before { @user.name = 'f' * 51 }
  	it { should be_invalid }
  end

  describe 'with invalid email' do
  	it 'should not be valid' do
	  	addresses = [	'Abc.example.com',
								  	'A@b@c@example.com',
								  	'a"b(c)d,e:f;g<h>i[j\k]l@example.com',
								  	'just"not"right@example.com',
								  	'this is"not\allowed@example.com',
								  	'this\ still\"not\\allowed@example.com',
								  	'this@..com',
								  ]
			addresses.each do |a|
				@user.email = a
				expect(@user).not_to be_valid
			end
		end
	end

	describe 'with valid email' do
		it 'should be valid' do
			addresses = ['niceandsimple@example.com',
									 'very.common@example.com',
									 'a.little.lengthy.but.fine@dept.example.com',
									 'disposable.style.email.with+symbol@example.com',
									]									
			addresses.each do |a|
				@user.email = a
				expect(@user).to be_valid
			end
		end
	end

	describe 'with email that already taken' do
		before do
			user_twin = @user.dup
			user_twin.email.upcase!
			user_twin.save
		end

		it { should_not be_valid }
	end


end
