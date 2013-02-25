class GalleryController < ApplicationController
  def index
    @whereabouts = "This is the Gallery View."
    @time = Time.now.asctime
    @events = Event.all

    @events_with_music = Event.with_music
    
  end
  
end
