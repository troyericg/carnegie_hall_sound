class FixColumnName < ActiveRecord::Migration
  def up
  end

  def down
  end
  
  def change
    rename_column :events, :licensee, :presenter
  end
  
end
