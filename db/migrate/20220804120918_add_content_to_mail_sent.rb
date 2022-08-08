class AddContentToMailSent < ActiveRecord::Migration[7.0]
  def change
      add_column :mail_sents, :content, :string
  end
end
