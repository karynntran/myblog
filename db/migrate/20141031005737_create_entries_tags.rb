class CreateEntriesTags < ActiveRecord::Migration
    def change
    create_table :tags do |t|
      t.integer :entry_id
      t.timestamps
    end
  end
end
