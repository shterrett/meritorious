class AddSchoolIdToTeacherStudentClassroom < ActiveRecord::Migration
  def change
    add_column :teachers, :school_id, :int
    add_index :teachers, :school_id
    add_column :students, :school_id, :int
    add_index :students, :school_id
    add_column :classrooms, :school_id, :int
    add_index :classrooms, :school_id
  end
end
