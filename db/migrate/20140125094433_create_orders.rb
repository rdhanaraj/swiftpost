class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :design

      t.timestamps
    end
  end
end
