class AddAttachmentDesignToOrders < ActiveRecord::Migration
  def self.up
    change_table :orders do |t|
      t.attachment :design
    end
  end

  def self.down
    drop_attached_file :orders, :design
  end
end
