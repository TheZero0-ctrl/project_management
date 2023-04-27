class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :priority
      t.st_point :lonlat, geographic: true, null: false
      t.float :longitude, null: false
      t.float :latitude, null: false
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tasks, :priority
  end
end
