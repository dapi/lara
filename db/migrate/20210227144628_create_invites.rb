class CreateInvites < ActiveRecord::Migration[6.1]
  def change
    create_table :invites, id: :uuid do |t|
      t.references :inviter, null: false, foreign_key: { to_table: :users }, type: :uuid, null: false
      t.string :full_name, null: false
      t.references :study_room, null: false, foreign_key: true, type: :uuid, null: false
      t.string :key, null: false
      t.string :role, null: false

      t.timestamps
    end

    add_index :invites, :key, unique: true
  end
end
