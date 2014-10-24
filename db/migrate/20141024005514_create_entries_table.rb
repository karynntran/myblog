class CreateEntriesTable < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :header, :limit => 1000
      t.string :post, :limit => 5000
      t.string :date_created
      t.timestamps
    end
  end
end