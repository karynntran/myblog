class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.text :body
      t.integer :entry_id
      t.integer :user_id

      t.timestamps
    end
  end
end
