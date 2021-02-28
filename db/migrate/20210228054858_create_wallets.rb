class CreateWallets < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets, id: :uuid do |t|
      t.references :student, null: false, foreign_key: true, type: :uuid, null: false
      t.integer :stars, null: false, default: 0

      t.timestamps
    end

    Student.find_each &:create_wallet!
  end
end
