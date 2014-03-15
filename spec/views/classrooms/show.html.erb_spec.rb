require 'spec_helper'

describe 'classrooms/show.html.erb' do
  it 'does not render an error partial if @errors is nil' do
    classroom = create(:classroom, :populated)
    assign(:classroom, classroom)
    assign(:students, classroom.students)

    render

    expect(rendered).not_to have_css 'ul#import-errors'
  end

  it 'renders the error partial if @errors exists' do
    classroom = create(:classroom, :populated)
    assign(:classroom, classroom)
    assign(:students, classroom.students)
    assign(:errors, { 'Ray Bradbury' => ['student_id cannot be blank'] })

    render

    expect(rendered).to have_css 'ul#import-errors'
    expect(rendered).to have_css 'li', text: 'Ray Bradbury: student_id cannot be blank'
  end
end
