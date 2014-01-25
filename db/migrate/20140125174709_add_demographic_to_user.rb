class AddDemographicToUser < ActiveRecord::Migration
  def change
    add_column :orders, :city, :string
    add_column :orders, :state, :string
    add_column :orders, :zipcode, :integer
  end
end
