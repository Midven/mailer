class AddUserToMessage < ActiveRecord::Migration[7.0]
  def change
      add_column :messages, :user_id, :int
  end
end
