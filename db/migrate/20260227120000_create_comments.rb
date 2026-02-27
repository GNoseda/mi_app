class CreateComments < ActiveRecord::Migration[8.1]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.boolean :ai_generated, null: false, default: false

      t.timestamps
    end
  end
end
