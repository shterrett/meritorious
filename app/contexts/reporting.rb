class Reporting
  def initialize(reporter)
    @reporter = reporter.as(Reporter)
  end

  def csv_data(type)
    CsvReportPresenter.new(['Student Name', 'Student id', 'Number of Merits', 'Number of Demerits'],
                           send("by_#{type}").map(&:to_row)
                          )
  end

  def by_meeting
    @reporter.classroom.students.each_with_object([]) do |student, students|
      students << StudentMarksPresenter.new(student).tap do |presenter|
        presenter.add_merits @reporter.merits.where(student_id: student.id)
        presenter.add_demerits @reporter.demerits.where(student_id: student.id)
      end
    end
  end
end
