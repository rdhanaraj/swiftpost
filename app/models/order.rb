require 'nokogiri'
require 'open-uri'
require 'addressable/uri'

class Order < ActiveRecord::Base
  attr_accessible :name, :address_line1, :address_line2, :address_city, 
    :address_state, :address_zip, :address_country

  belongs_to :user #user is basically the customer
  has_attached_file :design, styles: {thumbnail: "60x60#"}

  validates_attachment :design, :presence => true,
  :content_type => { :content_type => "application/pdf" }
  
  def create_address(city, state, zip)
    call_address = Addressable::URI.new(
     :scheme => "http",
     :host => "www.whitepages.com",
     :path => "search/FindNearby",
     :query_values => {
      :utf8 => "&#10003;",
      :street => "#{city}, #{state}",
      :where  => "#{zip}"
      }
   ).to_s
  end

  def scrape_the_data(url)
    doc = Nokogiri::HTML(open(url))
    addresses_and_ages = Hash.new()

    address_links = []
    addresses = []

    doc.css("a.map-location").map do |link|
      address_links << link['href'] #address_links
      addresses << link.css('span.title').children.text #address_line
    end

    i = 0
    address_links.each do |link|
      result = ""

      sub_doc = Nokogiri::HTML(open("http://www.whitepages.com#{link}"))
      debugger;

      sub_doc.css("span.clearfix").each do |age|
          result << age.content + " "
        end
        
        #take the average, or take lowest and highest and set that as the range
        addresses_and_ages[addresses[i]] = result.scan(/(\d+)/).sort.flatten
        i += 1
    end
    
    addresses_and_ages
  end
end
