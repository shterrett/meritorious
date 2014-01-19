class CreateClassAssignments < ActiveRecord::Migration
  def change
    create_table :class_assignments do |t|
      t.belongs_to :student, index: true
      t.belongs_to :classroom, index: true

      t.timestamps
    end
  end
end
