require 'spec_helper'

describe "StaticPages" do

	describe 'Home page' do
		it 'should have the "Кабинет" content' do
			visit '/static_pages/home'
			expect(page).to have_content 'Кабинет'
		end

		it 'should have the right title' do
			visit '/static_pages/home'
			expect(page).to have_title 'Кабинет'
		end
		
	end





end
