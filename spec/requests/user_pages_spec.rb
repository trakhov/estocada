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

  	before do
      sign_in user
      visit user_path user
    end

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

  describe 'edit' do
    let(:user) {FactoryGirl.create(:user)}
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe 'page' do
      it { should have_content 'Настройки'}
      it { should have_title 'Настройки'}
    end

    describe 'with invalid info' do
      before {click_button 'Сохранить'}

      it {should have_content 'внимание'}
      it {should have_selector 'div.alert.alert-error'}
    end

    describe 'with valid info' do
      let(:new_name) {"Освальд Иерихонович Брю"}
      let(:new_email) {"osvald@mail.ru"}      

      before do
        fill_in 'Имя Фамилия', with: new_name
        fill_in 'Электронная почта', with: new_email
        fill_in 'Новый пароль', with: 'newpassword'
        fill_in 'Подтверждение пароля', with: 'newpassword'
        click_button 'Сохранить'
      end

      it {should have_title new_name}
      it {should have_selector 'div.alert.alert-success'}
      it {should have_link 'Выйти'}
      specify {expect(user.reload.name).to eq new_name}
      specify {expect(user.reload.email).to eq new_email}
    end
  end

end
