class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :firstname
      t.string :surname
      t.string :middlename
      t.string :phone
      t.bigint :telegram_id, null: false
      t.jsonb :telegram_info, null: false

      t.timestamps
    end

    add_index :users, :telegram_id, unique: true
    add_reference :study_rooms, :classroom_teacher, foreign_key: { to_table: :users }, type: :uuid
  end
end
