class Event < ActiveRecord::Base
  attr_accessible :bio, :date, :img_url, :licensee, :location, :performers, :series_info, :title
  
  def correct_img_url
    if self.img_url != nil
      new_url = self.img_url.gsub(/\[|\]/,"").gsub(/\"/,"")
    end
    new_url
  end
  
  def correct_date
    timeDate = Time.parse(self.date)
    timeDate.strftime("%A, %B %d, %Y")
  end
end
