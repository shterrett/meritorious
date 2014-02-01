class AddNullConstraintsToTeacher < ActiveRecord::Migration
  def change
    change_column :teachers, :first_name, :string, null: false
    change_column :teachers, :last_name, :string, null: false
  end
end
