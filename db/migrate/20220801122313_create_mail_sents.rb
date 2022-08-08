class CreateMailSents < ActiveRecord::Migration[7.0]
  def change
    create_table :mail_sents do |t|
      t.string :recipient
      t.integer :message_id
      t.integer :user_id
      
      t.timestamps
    end
  end
end
