class AddAddressPartsToRecipient < ActiveRecord::Migration
  def change
    add_column :recipients, :city, :string
    add_column :recipients, :state, :string
    add_column :recipients, :zipcode, :integer
  end
end
