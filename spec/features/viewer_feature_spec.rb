require 'rails_helper'

feature 'user can view live results' do

  context 'starts voting' do
    before(:each) do
      user = create(:user)
      sign_in_as(user)
    end

    it 'shows both votes as 0' do
      visit '/'
      click_link 'Add a poll'
      fill_in 'Name', with: "Can you code?"
      click_button('Create Poll')
      expect(page).to have_content('0')
    end
  end
end
