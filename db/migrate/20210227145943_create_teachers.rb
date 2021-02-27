class CreateTeachers < ActiveRecord::Migration[6.1]
  def change
    create_table :teachers, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid, null: false
      t.references :study_room, null: false, foreign_key: true, type: :uuid, null: false

      t.timestamps
    end

    add_index :teachers, [:study_room_id, :user_id], unique: true
  end
end
