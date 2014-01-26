class AddOrderIdToRecipient < ActiveRecord::Migration
  def change
    add_column :recipients, :order_id, :integer
    add_index :recipients, :order_id
  end
end
