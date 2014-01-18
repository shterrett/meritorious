class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.string :name
      t.belongs_to :teacher

      t.timestamps
    end
  end
end
