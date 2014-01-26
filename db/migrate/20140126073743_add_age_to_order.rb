class AddAgeToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :starting_age, :integer
    add_column :orders, :ending_age, :integer
  end
end
