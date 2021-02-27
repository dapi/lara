class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid, null: false
      t.references :study_room, null: false, foreign_key: true, type: :uuid, null: false

      t.timestamps
    end

    add_index :students, [:user_id, :study_room_id], unique: true
  end
end
