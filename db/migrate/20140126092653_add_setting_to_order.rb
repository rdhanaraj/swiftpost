class AddSettingToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :setting, :string
  end
end
