class RemoveNullifyInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :firstname, false
  end
end
