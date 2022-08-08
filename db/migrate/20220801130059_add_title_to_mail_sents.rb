class AddTitleToMailSents < ActiveRecord::Migration[7.0]
  def change
    add_column :mail_sents, :title, :string
  end
end
