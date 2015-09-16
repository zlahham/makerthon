require 'rails_helper'

describe 'Voting' do

  context 'user is signed in' do

    before do
      user = create(:user)
      sign_in_as(user)
    end

    it 'can upvote' do
      create_poll('test poll')
      expect(page).to have_button('Upvote')
    end

    it 'can downvote' do
      create_poll('test poll')
      expect(page).to have_button('Downvote')
    end
  end

  context 'user not signed in' do

    it 'cannot upvote' do
      visit '/'
      expect(page).to have_content 'Sign up'
      expect(page).not_to have_content 'Upvote'
    end

    it 'cannot downvote' do
      visit '/'
      expect(page).to have_content 'Sign up'
      expect(page).not_to have_content 'Downvote'
    end
  end

  context 'can be done by Downvote and Upvote' do

    before do
      user = create(:user)
      sign_in_as(user)
      create_poll('test poll')
    end

    it 'downvoting registers vote' do
      visit '/'
      click_button 'Downvote'
      expect(page).to have_content('Your vote status: -1')
    end

    it 'upvoting registers vote' do
      visit '/'
      click_button 'Upvote'
      expect(page).to have_content('Your vote status: 1')
    end
  end
end
