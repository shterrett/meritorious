class AssigningMarks
  def initialize(teacher, student)
    @assigner = teacher.as(Assigner)
    @assignee = student.as(Assignee)
  end

  def assign(mark)
    if @assigner.can_assign? @assignee
      @assignee.marks << mark
    end
  end
end
