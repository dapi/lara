class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships, id: :uuid do |t|
      t.references :parent, null: false, foreign_key: { to_table: :users }, type: :uuid, null: false
      t.references :children, null: false, foreign_key: { to_table: :users }, type: :uuid, null: false

      t.timestamps
    end

    add_index :relationships, [:parent_id, :children_id], unique: true
  end
end
