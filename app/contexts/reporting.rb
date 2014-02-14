class Reporting
  def initialize(reporter)
    @reporter = reporter.as(Reporter)
  end

  def csv_data(type)
    CsvReportPresenter.new(['Student Name', 'Student id', 'Number of Merits', 'Number of Demerits'],
                           send("by_#{type}").map(&:to_row)
                          )
  end

  def data(type, *args)
    send("by_#{type}", *args)
  end

  private

  def by_meeting
    @reporter.classroom.students.each_with_object([]) do |student, students|
      students << student_presenter_for(student)
    end
  end

  def by_student_meeting(student)
    student_presenter_for(student)
  end

  def student_presenter_for(student)
    StudentMarksPresenter.new(student).tap do |presenter|
      presenter.add_merits @reporter.merits.where(student_id: student.id)
      presenter.add_demerits @reporter.demerits.where(student_id: student.id)
    end
  end
end
