class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :pin, null: false, foreign_key: true
      t.integer :comment_id
      t.integer :user_id

      t.timestamps
    end
  end
end
