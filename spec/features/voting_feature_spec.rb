require 'rails_helper'

describe 'Voting' do

  context 'user is signed in' do

    before do
      user = create(:user)
      sign_in_as(user)
      poll = create(:poll)
    end

    it 'can upvote' do
      visit '/'
      expect(page).to have_content('Upvote')
    end

    it 'can downvote' do
      visit '/'
      expect(current_path).to eq('/')
      expect(page).to have_content('Downvote')
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
      poll = create(:poll)
    end

    it 'downvoting registers vote' do
      visit '/'
      click_link 'Downvote'
      expect(page).to have_content('-1')
    end

    it 'upvoting registers vote' do
      visit '/'
      click_link 'Upvote'
      expect(page).to have_content('1')
    end
  end
end
