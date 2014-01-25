class Order < ActiveRecord::Base
  belongs_to :user
  has_attached_file :design, styles: {thumbnail: "60x60#"}

  validates_attachment :design, :presence => true,
  :content_type => { :content_type => "application/pdf" }
end
