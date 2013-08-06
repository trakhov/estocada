require 'spec_helper'

describe "Authentication" do

	subject { page }

	describe 'signin page' do 
		before { visit signin_path }

		it { should have_content 'Вход'}
		it { should have_title 'Вход'}
	end

	describe 'signin' do
		before { visit signin_path }

		describe 'with invalid info' do
			before { click_button 'Войти' }

			it { should have_title 'Вход' }
			it { should have_selector 'div.alert.alert-error', text: 'Не' }

			describe 'after visiting another page' do
				before { click_link 'Estocada' }
				it { should_not have_selector 'div.alert.alert-error' }
			end
		end

		describe 'with valid info' do
			let(:user) { FactoryGirl.create(:user) }
			before do
				fill_in 'Электронная почта', with: user.email.upcase
				fill_in 'Пароль', with: user.password
				click_button 'Войти'
			end

			it { should have_title(user.name) }
			it { should have_link 'Профиль', href: user_path(user) }
			it { should have_link 'Выйти', href: signout_path }
			it { should_not have_link 'Войти', href: signin_path }

			describe 'followed by signout' do
				before { click_link 'Выйти' }
				it { should have_link 'Войти'}
			end
		end
	end

	describe 'authorization' do
		
		describe 'for non-signed-in users' do
			let(:user) {FactoryGirl.create(:user)}

			describe 'in the Users controller' do

				describe 'visiting the edit page' do
					before {visit edit_user_path(user)}
					it {should have_title 'Вход'}
				end

				describe 'submitting to the update action' do
					before {patch user_path(user)}
					specify {expect(response).to redirect_to signin_path}
				end
			end

			describe 'when attempting to visit a protected page' do
				before do
					visit edit_user_path(user)
					fill_in 'Электронная почта', with: user.email
					fill_in 'Пароль', with: user.password
					click_button 'Войти'
				end

				describe 'after sign in' do
					it 'should render desired protected page' do
						expect(page).to have_title 'Настройки'
					end
				end
			end

		end

		describe 'as wrong user' do
			let(:user) {FactoryGirl.create(:user)}
			let(:wrong_user) {FactoryGirl.create(:user, email: "wong@choo.fu")}
			before {sign_in user, no_capybara: true}

			describe 'visiting Users#edit page' do
				before {visit edit_user_path(wrong_user)}
				it {should_not have_title 'Изменение данных'}
			end

			describe 'submitting a patch request to the Users#update action' do
				before {patch user_path(wrong_user)}
				specify {expect(response).to redirect_to(root_url)}
			end
		end





	end




end
