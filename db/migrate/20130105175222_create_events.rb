class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :licensee
      t.string :date
      t.string :title
      t.string :location
      t.string :bio
      t.string :series_info
      t.string :performers
      t.string :img_url

      t.timestamps
    end
  end
end
