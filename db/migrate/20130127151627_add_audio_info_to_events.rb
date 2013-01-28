class AddAudioInfoToEvents < ActiveRecord::Migration
  def change
    add_column :events, :audio_info, :text
  end
end
