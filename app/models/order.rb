require 'nokogiri'
require 'open-uri'
require 'addressable/uri'

class Order < ActiveRecord::Base
  belongs_to :user
  has_attached_file :design, styles: {thumbnail: "60x60#"}

  validates_attachment :design, :presence => true,
  :content_type => { :content_type => "application/pdf" }
  
  def create_address(city, state, zip)
    call_address = Addressable::URI.new(
     :scheme => "https",
     :host => "www.whitepages.com",
     :path => "search/FindNearby",
     :query_values => {
      :utf8 => "✓",
      :street => "#{city}, #{state}",
      :where  => "#{zip}"
      }
   ).to_s
  end

  def scrape_the_data(url)
    doc = Nokogiri::HTML(open(url))

    addresses = doc.css("span.title").map do |node|
      node.content
    end

    addresses
  end
end
