class MoveMarksToMeeting < ActiveRecord::Migration
  def change
    rename_column :marks, :classroom_id, :meeting_id
  end
end
