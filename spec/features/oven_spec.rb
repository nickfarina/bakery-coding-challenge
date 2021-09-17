feature 'Oven' do
  scenario 'Creating an account' do
    sign_up_with('myemail@test.com', 'abcdefgh', 'abcdefgh')

    oven = User.last.ovens.first
    expect(oven).to_not be_nil
    expect(oven.name).to eq('My First Oven')
  end

  scenario 'Viewing an oven page' do
    user = create_and_signin
    oven = user.ovens.first

    visit root_path
    click_link "View your ovens"
    click_link oven.name

    expect(current_path).to eq(oven_path(oven))
    expect(page).to have_content oven.name
  end

  scenario 'Oven is empty' do
    user = create_and_signin
    oven = user.ovens.first

    visit root_path
    click_link "View your ovens"
    click_link oven.name

    expect(current_path).to eq(oven_path(oven))
    expect(page).to have_content oven.name
    expect(page).to have_content 'Curently in oven: Nothing'
    expect(page).to_not have_content "- and they're ready!"
  end

  scenario 'Oven is full, cookies not finished' do
    user = create_and_signin
    oven = user.ovens.first
    Cookie.create!(fillings: 'PB&J', storage: oven)

    visit root_path
    click_link "View your ovens"
    click_link oven.name

    expect(current_path).to eq(oven_path(oven))
    expect(page).to have_content oven.name
    expect(page).to have_content 'Curently in oven: 1 PB&J cookie(s)'
    expect(page).to have_css('.retrieve-section', visible: 'hidden', text: "- and they're ready!")
  end

  scenario 'Oven is full, cookies are finished' do
    user = create_and_signin
    oven = user.ovens.first
    Cookie.create!(fillings: 'PB&J', storage: oven, ready: true)

    visit root_path
    click_link "View your ovens"
    click_link oven.name

    expect(current_path).to eq(oven_path(oven))
    expect(page).to have_content oven.name
    expect(page).to have_content 'Curently in oven: 1 PB&J cookie(s)'
    expect(page).to have_css('.retrieve-section', visible: 'visible', text: "- and they're ready!")
  end
end
