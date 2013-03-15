class Event < ActiveRecord::Base
  attr_accessible :bio, :date, :img_url, :licensee, :location, :performers, :series_info, :title, :audio_id
  
  # def correct_img_url
  #   if self.img_url != nil
  #     new_url = self.img_url.gsub(/\[|\]/,"").gsub(/\"/,"")
  #   end
  #   new_url
  # end
  


  scope :with_music, {:conditions => [ "audio_id != ?", "" ]}
  
  # def correct_audio_id
  #   if self.audio_id != nil
  #     new_id = self.audio_id.gsub(/\[|\]/,"").gsub(/\"/,"")
  #   end
  #   new_id
  # end

end