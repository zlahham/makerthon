require 'rails_helper'

describe 'Poll' do

  before do
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
end
