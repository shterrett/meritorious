require 'spec_helper'

feature 'top level navigation' do
  scenario 'links to classrooms_path' do
    classroom = create(:classroom)
    teacher = classroom.teacher

    sign_in_as teacher
    visit root_path

    within 'nav.main' do
      click_link 'Classrooms'
    end

    expect(page).to have_content "Classrooms for #{teacher.name}"
    expect(page).to have_css "[data-role='classroom-#{classroom.id}']", text: classroom.name
  end

  scenario 'links to root_path using application name' do
    teacher = create(:teacher)

    sign_in_as teacher
    visit classrooms_path

    within 'nav.main' do
      click_link 'meritorious'
    end

    expect(page).to have_content 'meritorious'
  end

  scenario 'renders the proper header depending on context' do
    teacher = create(:teacher)

    visit root_path
    within 'nav.main' do
      expect(page).to have_css 'ul.signed-out'
      expect(page).to have_link 'Sign In', href: new_teacher_session_path
      click_link 'Sign In'
    end

    fill_in 'Email', with: teacher.email
    fill_in 'Password', with: 'password123'
    click_button 'Sign in'

    within 'nav.main' do
      expect(page).to have_css 'ul.signed-in'
      expect(page).to have_link 'Sign Out', href: destroy_teacher_session_path
    end
  end
end
