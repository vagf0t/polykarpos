class CreateFileUploads < ActiveRecord::Migration[5.0]
  def change
    create_table :file_uploads do |t|
      t.string :name
      t.string :attachment
      t.string :genders
      t.timestamps
    end
  end
end
