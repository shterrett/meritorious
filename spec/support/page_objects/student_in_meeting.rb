class StudentInMeeting < PageObject::Base
  MARK_LINKS = { merit: '+', demerit: '-' }

  def initialize(student)
    @student = student
    @meeting_id = meeting_id_from_path
    @initial_mark_count = {}
  end

  def add_mark(type)
    within student_div do
      initial_mark_count[type] = mark_count(type)
      click_link MARK_LINKS[type]
    end
  end

  def has_added_mark?(type)
    within student_div do
      mark_count(type) == initial_mark_count[type] + 1
    end
  end

  def has_merit_link?
    page.has_link? '+', href: meeting_marks_path(meeting_id,
                                                 mark: { type: :merit },
                                                 student_id: student.id
                                                )
  end

  def has_demerit_link?
    page.has_link? '-', href: meeting_marks_path(meeting_id,
                                                 mark: { type: :demerit },
                                                 student_id: student.id
                                                )
  end

  def has_student_on_page?
    within student_div do
      page.has_content? student.name
    end
  end

  private
  attr_accessor :initial_mark_count
  attr_reader :meeting_id, :student

  def meeting_id_from_path
    (page.current_path.split('/'))[2]
  end

  def mark_count(type)
    find(".#{type}s-count").text.to_i
  end

  def student_div
    "[data-role='student-#{student.id}']"
  end
end
