class CreateStudyRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :study_rooms, id: :uuid do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
