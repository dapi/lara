class CreateWalletTransfers < ActiveRecord::Migration[6.1]
  def change
    create_table :wallet_transfers, id: :uuid do |t|
      t.references :wallet, null: false, foreign_key: true, type: :uuid, null: false
      t.references :payer, null: false, foreign_key: { to_table: :users }, type: :uuid, null: false
      t.integer :stars, null: false
      t.string :message, null: false

      t.timestamps
    end
  end
end
