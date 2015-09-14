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

    xit 'can downvote' do

    end
  end
end
