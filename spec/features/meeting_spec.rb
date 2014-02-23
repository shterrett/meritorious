require 'spec_helper'

feature 'meetings' do
  it 'creates a meeting from the list of classrooms' do
    classroom = create(:classroom)
    teacher = classroom.teacher

    sign_in_as teacher
    visit classrooms_path

    Timecop.freeze do
      start_meeting_for(classroom)

      expect(page).to have_content classroom.name
      expect(page).to have_content I18n.l Time.zone.now, format: :day_time
    end
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
    start_meeting_for(classroom)

    student_on_page = StudentInMeeting.new(student)

    expect(student_on_page).to have_student_on_page
    expect(student_on_page).to have_demerit_link
    expect(student_on_page).to have_merit_link
  end

  it 'adds a merit to a student', js: true do
    classroom = create(:classroom)
    teacher = classroom.teacher
    student = create(:student, school: classroom.school)
    classroom.students << student

    sign_in_as teacher
    visit classrooms_path
    start_meeting_for(classroom)

    student_on_page = StudentInMeeting.new(student)

    student_on_page.add_mark(:merit)
    expect(student_on_page).to have_added_mark(:merit)
  end

  it 'adds a demerit to a student', js: true do
    classroom = create(:classroom)
    teacher = classroom.teacher
    student = create(:student, school: classroom.school)
    classroom.students << student

    sign_in_as teacher
    visit classrooms_path
    start_meeting_for(classroom)

    student_on_page = StudentInMeeting.new(student)

    student_on_page.add_mark(:demerit)
    expect(student_on_page).to have_added_mark(:demerit)
  end

  it 'exports a csv report for the meeting', js: true do
    classroom = create(:classroom)
    teacher = classroom.teacher
    student = create(:student, school: classroom.school)
    classroom.students << student

    sign_in_as teacher
    visit classrooms_path
    start_meeting_for(classroom)

    student_on_page = StudentInMeeting.new(student)
    student_on_page.add_mark(:demerit)

    click_button 'Export Meeting Report'

    expect(page).to have_text(['Student Name', 'Student id', 'Number of Merits', 'Number of Demerits'].join(','))
  end

  def start_meeting_for(classroom)
    within "[data-role='classroom-#{classroom.id}']" do
      click_button 'Start Class'
    end
  end
end
