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
        
        #grabs event title/performer
        showTitle = cur_page.css('.eventTitle').text.strip
        event.title = showTitle
        puts "Show title: #{showTitle}"
        
        #grabs licensee/presenter
        presentedBy = cur_page.css('.licensee').text.strip
        event.presenter = presentedBy
        puts "Presented by: #{presentedBy}"
        
        #grabs event date
        showDate = cur_page.css('span.event_date').text.strip
        event.date = showDate
        puts "date: #{showDate}"
        
        #grabs intro/bio paragraph
        introBio = cur_page.css('.event-general-notes').text.strip
        event.bio = introBio
        puts "- intro/bio paragraph"
        
        #grabs series info (if available)
        seriesInfo = cur_page.css('.evnt-series').text.gsub!(/\s+/," ")
        event.series_info = seriesInfo
        puts "- series info (if available)"
        
        #grabs list of performers
        performers = cur_page.css('.event-left-display ul li')[0].text.gsub(/\.\.+|^\n/,", ")
        performers.gsub!("St. Luke's", "St. Luke's, ")
        event.performers = performers
        puts "- list of performers"
        
        #grabs image url and uses regexes to turn them into useable links
        img_url = cur_page.css('img.event').map { |link| link['src'].match(regex_img).to_s.gsub!(/\i\./, "www.") }
        event.img_url = img_url[0]
        puts "- image url: #{img_url[0]}"
        
        #grabs audio file ID
        audioID = cur_page.css('param[name="flashVars"]').map { |para| para['value'] }
        event.audio_id = audioID[0]
        puts "- audio ID: #{audioID[0]}"
        
        #grabs audio file info 
        audioInfo = cur_page.css('.event-right-display .evnt-audio').text.gsub!(/\s+/," ")
        event.audio_info = audioInfo
        puts "- audio Info: #{audioInfo}"
        
        #grabs ticket purchasing link 
        ticketID = cur_page.css('a.sc-ivite').map { |link| link['href'].match(/\d+/) }
        ticketLink = "https://www.carnegiehall.org/SiteCode/Purchase/SYOS/SeatSelection.aspx?startWorkflow=true&quickBuy=false&quantity=0&eventId=#{ticketID[0]}"
        event.ticket_link = ticketLink
        puts "- ticket ID: #{ticketID[0]}"

        #grabs ticket price
        ticketPrice = cur_page.css('.evnt-priceInfo').text
        event.price = ticketPrice
        puts "- ticket price: #{ticketPrice}"
        
        
        event.save!
        puts "grabbed the all data, shoved it into the database."
        puts "----------------"
        puts 
        
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