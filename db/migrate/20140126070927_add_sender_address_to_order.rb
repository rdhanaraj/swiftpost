class AddSenderAddressToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :sender_city, :string
    add_column :orders, :sender_state, :string
    add_column :orders, :sender_zipcode, :string
  end
end
