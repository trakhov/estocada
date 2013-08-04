require 'spec_helper'

describe User do
  
  before do 
  	@user = User.new	name: 'Петров Сергей Иванович', 
											email: 'petrov@gmail.com',
											password: 'fuckingpassword',
											password_confirmation: 'fuckingpassword'
	end


  subject { @user }

  it { should respond_to :name }
  it { should respond_to :email }
  it { should respond_to :password_digest }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :authenticate }

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

	describe 'with no password' do
		before do
			@user = User.new	name: "Foo",
												email: "bar@dot.com",
												password: ' ',
												password_confirmation: ' '
		end
		it { should_not be_valid }
	end

	describe 'when password does not match confirmation' do
		before { @user.password_confirmation = 'moomatch' }
		it { should_not be_valid }
	end

	describe 'return value of authentication' do
		before { @user.save }
		let(:found_user) {User.find_by(email: @user.email)}

		describe 'with valid password' do
			it { should eq found_user.authenticate(@user.password) }
		end

		describe 'with invalid password' do
			let(:user_invalid_password) {found_user.authenticate('invalid')}

			it { should_not eq user_invalid_password }
			specify { expect(user_invalid_password).to be_false }
		end

		describe 'with too short password' do
			before { @user.password = @user.password_confirmation = 'a' * 5 }
			it { should be_invalid }
		end
	end


end
