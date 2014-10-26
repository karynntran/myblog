class AddPhotoColumnToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :photo_link, :string
  end
end
