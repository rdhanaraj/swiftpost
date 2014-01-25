class Order < ActiveRecord::Base

  belongs_to :user
  has_attached_file :design, styles: {thumbnail: "60x60#"}

  validates_attachment :design, :presence => true, :content_type => { :content_type => "application/pdf" }


  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by_id(params['id'])
      product.update_attributes(row)
      p product
      p "-------**************************--------"
      product.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Csv.new(file.path, nil, :ignore)
      when ".xls" then Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Excelx.new(file.path, nil, :ignore)
    end
  end

end
