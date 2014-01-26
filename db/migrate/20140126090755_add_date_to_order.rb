class AddDateToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :order_date, :date
  end
end
