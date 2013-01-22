require 'rest-client'
require 'mechanize'
require 'nokogiri'
require 'open-uri'

namespace :db do
  desc "Putting data in the datbase"
  task :populate => :environment do
    
    #Set up basic variables
    BASE_URL = 'http://www.carnegiehall.org'
    URL = 'http://www.carnegiehall.org/Calendar/'
    
    #Set up regexes
    regex_title = /(M\/)([\w+\-]+)/
    regex_img = /http:(.+)\.\w+/  #to grab http
    
    #Set up empty arrays
    #loc = []
    pageLinks = []
    count = 0

    #Set up mechanize
    agent = Mechanize.new()
    agent.get(URL)
    
    #Grabs all event links and puts them in an array
    agent.page.search(".event_title a").each do |link|
      pageLinks << BASE_URL + link['href']
    end
    
    #TK: Will grab all event locations and add them to a multidimensional array
    # agent.page.search(".event_loc").each do |txt|
    #   loc << txt.text
    # end
    
    
    pageLinks.each do |pg|
      
      event = Event.new()
      
      begin
        cur_page = Nokogiri::HTML(open(pg))
        #grabs licensee
        event.licensee = cur_page.css('.licensee').text.strip

        #grabs event date
        event.date = cur_page.css('span.event_date').text.strip

        #grabs event title/performer
        event.title = cur_page.css('.eventTitle').text.strip

        #grabs intro/bio paragraph
        event.bio = cur_page.css('.event-general-notes').text.strip

        #grabs series info (if available)
        event.series_info = cur_page.css('.evnt-series').text.gsub!(/\s+/," ")

        #grabs list of performers
        performers = cur_page.css('.event-left-display ul li')[0].text.gsub(/\.\.+|^\n/,", ")
        performers.gsub!("St. Luke's", "St. Luke's, ")
        event.performers = performers

        #grabs image url and uses regexes to turn them into useable links
        img_url = cur_page.css('img.event').map { |link| link['src'].match(regex_img).to_s.gsub!(/\i\./, "www.") }
        event.img_url = img_url.to_s

        event.save!
        
        sleep 2
        
      rescue StandardError => e
        count += 1
        puts "--------------------------------------------"
        puts "Fail Number: #{count} "
        puts "Fail Reason: #{e}"
        
      end
      
    end
    
    
  end
end