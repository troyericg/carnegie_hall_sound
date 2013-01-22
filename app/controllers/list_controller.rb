class ListController < ApplicationController
  def index
    @whereabouts = "This is the List View."
    @time = Time.now.asctime
    @events = Event.all
    
  end
end
