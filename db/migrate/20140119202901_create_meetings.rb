class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.belongs_to :classroom, index: true

      t.timestamps
    end
  end
end
