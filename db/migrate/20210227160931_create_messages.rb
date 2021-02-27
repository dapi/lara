class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid, null: false
      t.bigint :chat_id, null: false
      t.text :text
      t.jsonb :payload, null: false
      t.bigint :message_id, null: false
      t.bigint :reply_to_message_id

      t.timestamps
    end
  end
end
