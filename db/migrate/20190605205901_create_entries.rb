class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.string :content
      t.string :image
      t.integer :owner_id

      t.timestamps
    end
  end
end
