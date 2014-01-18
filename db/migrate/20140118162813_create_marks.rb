class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.belongs_to :student, index: true
      t.belongs_to :teacher, index: true
      t.belongs_to :classroom, index: true
      t.belongs_to :content, index: true
      t.string :content_type

      t.timestamps
    end
  end
end
