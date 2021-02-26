class CreateMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :memberships, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid, null: false
      t.references :study_room, null: false, foreign_key: true, type: :uuid, null: false
      t.boolean :is_teacher, null: false, default: false
      t.boolean :is_student, null: false, default: false
      t.boolean :is_parent, null: false, default: false
      t.boolean :is_lead, null: false, default: false

      t.timestamps
    end

    add_index :memberships, [:study_room_id, :user_id], unique: true
  end
end
