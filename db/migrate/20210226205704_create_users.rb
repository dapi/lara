class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :firstname
      t.string :surname
      t.string :middlename
      t.string :phone

      t.timestamps
    end
  end
end
