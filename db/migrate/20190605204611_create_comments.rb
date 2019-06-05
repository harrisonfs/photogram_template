class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :commenter_id
      t.integer :photo_id

      t.timestamps
    end
  end
end
