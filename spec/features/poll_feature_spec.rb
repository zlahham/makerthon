require 'rails_helper'

describe 'Poll' do

  before(:each) do
    user = create(:user)
    sign_in_as(user)
  end

  context 'no Polls have been added' do
    scenario 'should display a prompt to add a poll' do
      visit '/'
      expect(page).to have_content 'No polls yet'
      expect(page).to have_link 'Add a poll'
    end
  end

  context 'Creates a poll' do
    scenario 'user can create a poll' do
      visit '/'
      click_link 'Add a poll'
      fill_in 'Name', with: "Can you explain Duck Typing?"
      click_button('Create Poll')
      expect(current_path).to eq('/')
      expect(page).to have_content('Can you explain Duck Typing?')
    end
  end
end
