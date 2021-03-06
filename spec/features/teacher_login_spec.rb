require 'spec_helper'

feature 'teacher signs in' do
  scenario 'signs in from home page' do
    teacher = create(:teacher, password: 'password123')

    visit root_path

    click_link 'Sign In'
    fill_in 'Email', with: teacher.email
    fill_in 'Password', with: 'password123'
    click_button 'Sign in'

    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'signs out' do
    teacher = create(:teacher)

    sign_in_as teacher

    visit classrooms_path

    click_link 'Sign Out'
    expect(page).to have_content 'meritorious'
    expect(page).to have_link 'Sign In'
  end
end
