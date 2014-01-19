class AssigningMarks
  def initialize(teacher, student)
    @assigner = teacher.as(Assigner)
    @assignee = student.as(Assignee)
  end

  def assign(mark)
    if @assigner.students.include? @assignee
      @assignee.marks << mark
    end
  end
end
