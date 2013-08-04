require 'spec_helper'

describe "UserPages" do

	subject { page }

	describe 'signup page' do
		before { visit signup_path }

		it { should have_content 'Регистрация' }
		it { should have_title 'Регистрация' }
		it { should have_selector 'h1', text: 'Регистрация' }
  end

  describe 'profile page' do
  	let(:user) { FactoryGirl.create(:user) }

  	before { visit user_path user }

  	it { should have_content user.name }
  	it { should have_title user.name }
  end

  describe 'signup' do
  	before { visit signup_path }
  	let(:submit) { 'Пополнить ряды' }

  	describe 'with invalid information' do
  		it 'should not create user' do
  			expect { click_button submit }.not_to change(User, :count)
  		end
  	end

  	describe 'with valid information' do
  		before do
  			fill_in 'Имя Фамилия', with: 'Антонов Юрий'
  			fill_in 'Электронная почта', with: 'antonov@mail.ru'
  			fill_in 'Пароль', with: 'antonov'
  			fill_in 'Подтверждение пароля', with: 'antonov'
  		end

  		it 'should create a user' do
  			expect { click_button submit }.to change(User, :count).by 1
  		end

      describe 'after saving the user' do
        before { click_button submit }
        let(:user) { User.find_by(email: 'antonov@mail.ru') }

        it { should have_link 'Выйти' }
        it { should have_title user.name }
        it { should have_selector('div.alert.alert-success', text: 'Добро пожаловать') }
      end
    end
  end


end
