require 'spec_helper'

describe "UserPages" do

	subject { page }

	describe 'signup page' do
		before { visit signup_path }

		it { should have_content 'Регистрация' }
		it { should have_title 'Регистрация' }
		it { should have_selector 'h1', text: 'Регистрация' }
  end

end
