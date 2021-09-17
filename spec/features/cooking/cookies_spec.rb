feature 'Cooking cookies' do
  scenario 'Cooking a single cookie', perform_jobs: true do
    user = create_and_signin
    oven = user.ovens.first

    ActiveJob::Base.queue_adapter.perform_enqueued_jobs do
      visit oven_path(oven)

      expect(page).to_not have_content 'Chocolate Chip'
      expect(page).to_not have_content "and they're ready"

      click_link_or_button 'Prepare Cookie'
      fill_in 'Fillings', with: 'Chocolate Chip'
      click_button 'Mix and bake'


      visit current_path

      expect(current_path).to eq(oven_path(oven))
      expect(page).to have_content 'Chocolate Chip'
      expect(page).to have_content "and they're ready"

      click_button 'Retrieve Cookie'
      expect(page).to_not have_content 'Chocolate Chip'
      expect(page).to_not have_content "and they're ready"

      visit root_path
      within '.store-inventory' do
        expect(page).to have_content '1 Cookie'
      end
    end
  end

  scenario 'Trying to bake a cookie while oven is full' do
    user = create_and_signin
    oven = user.ovens.first

    oven = create(:oven, user: user)
    visit oven_path(oven)

    click_link_or_button 'Prepare Cookie'
    fill_in 'Fillings', with: 'Chocolate Chip'
    click_button 'Mix and bake'

    click_link_or_button  'Prepare Cookie'
    expect(page).to have_content 'Something is already in the oven!'
    expect(current_path).to eq(oven_path(oven))
    expect(page).to_not have_button 'Mix and bake'
  end

  scenario 'Baking multiple cookies' do
    user = create_and_signin
    oven = user.ovens.first

    ActiveJob::Base.queue_adapter.perform_enqueued_jobs do
      visit oven_path(oven)

      3.times do
        click_link_or_button 'Prepare Cookie'
        fill_in 'Fillings', with: 'Chocolate Chip'
        click_button 'Mix and bake'

        click_button 'Retrieve Cookie'
      end

      visit root_path
      within '.store-inventory' do
        expect(page).to have_content '3 Cookies'
      end
    end
  end
end
