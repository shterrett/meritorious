require 'spec_helper'

feature 'classrooms' do
  scenario 'views list of classrooms' do
    school = create(:school)
    teacher = create(:teacher, school: school)
    classrooms = create_list(:classroom, 2,
                             teacher: teacher,
                             school: school
                            )

    sign_in_as teacher
    visit classrooms_path

    classrooms.each do |classroom|
      within "[data-role='classroom-#{classroom.id}']" do
        expect(page).to have_link(classroom.name, href: classroom_path(classroom))
      end
    end
  end

  scenario 'shows students and classroom details' do
    classroom = create(:classroom)
    teacher = classroom.teacher
    students = create_list(:student, 2, school: classroom.school)
    classroom.students << students

    sign_in_as teacher
    visit classroom_path(classroom)

    expect(page).to have_css 'h1', text: classroom.name
    students.each do |student|
      expect(page).to have_css '[data-role="student"]', text: student.name
    end
  end
end
