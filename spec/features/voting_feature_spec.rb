require 'rails_helper'

describe 'Voting' do

  context 'is done by users signed in' do
    it 'can upvote' do
      visit '/'
      click_link 'Sign up'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'testtest'
      fill_in 'Password confirmation', with: 'testtest'
      click_button 'Sign up'
      expect(current_path).to eq('/')
      expect(page).to have_content('Upvote')
    end

    it 'can downvote' do
      visit '/'
      click_link 'Sign up'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'testtest'
      fill_in 'Password confirmation', with: 'testtest'
      click_button 'Sign up'
      expect(current_path).to eq('/')
      expect(page).to have_content('Downvote')
    end
  end

  context 'cannot be done by users not signed in' do
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
end