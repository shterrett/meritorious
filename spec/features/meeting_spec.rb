require 'spec_helper'

feature 'meetings' do
  it 'creates a meeting from the list of classrooms' do
    classroom = create(:classroom)
    teacher = classroom.teacher

    sign_in_as teacher
    visit classrooms_path

    within "[data-role='classroom-#{classroom.id}']" do
      click_button 'Start Class'
    end

    expect(page).to have_content classroom.name
    expect(page).to have_content I18n.l DateTime.now, format: :day_time
  end

  it 'ends a meeting and returns to the classroom list' do
    classroom = create(:classroom)
    teacher = classroom.teacher

    sign_in_as teacher
    visit classrooms_path

    within "[data-role='classroom-#{classroom.id}']" do
      click_button 'Start Class'
    end

    click_link 'End Class'

    expect(page).to have_text "Classrooms for #{teacher.name}"
  end

  it 'lists students in the associated classroom with links for assigning marks' do
    classroom = create(:classroom)
    teacher = classroom.teacher
    student = create(:student, school: classroom.school)
    classroom.students << student

    sign_in_as teacher
    visit classrooms_path

    within "[data-role='classroom-#{classroom.id}']" do
      click_button 'Start Class'
    end

    meeting_id = (page.current_path.split('/'))[2]

    within "[data-role='student-#{student.id}']" do
      expect(page).to have_text student.name
      expect(page).to have_link '+', href: meeting_marks_path(meeting_id)
      expect(page).to have_link '-', href: meeting_marks_path(meeting_id)
    end
  end
end
