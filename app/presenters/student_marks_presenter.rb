class StudentMarksPresenter
  attr_reader :merits, :demerits

  def initialize(student)
    @student = student
    @merits = []
    @demerits = []
  end

  def name
    @student.name
  end

  def student_id
    @student.student_id
  end

  def id
    @student.id
  end

  def merits_count
    @merits.length
  end

  def demerits_count
    @demerits.length
  end

  def add_merits(merits)
    @merits.concat(merits)
  end

  def add_demerits(demerits)
    @demerits.concat(demerits)
  end

  def to_row
    [name, student_id, @merits.length, @demerits.length]
  end
end
