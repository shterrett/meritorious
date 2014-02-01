class AddNullConstraintToStudents < ActiveRecord::Migration
  def change
    change_column :students, :student_id, :string, null: false
    change_column :students, :first_name, :string, null: false
    change_column :students, :last_name, :string, null: false
  end
end
