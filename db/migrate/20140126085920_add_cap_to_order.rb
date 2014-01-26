class AddCapToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :cap, :integer
  end
end
