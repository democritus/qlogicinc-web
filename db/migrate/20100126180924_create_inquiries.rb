class CreateInquiries < ActiveRecord::Migration
  def self.up
    create_table :inquiries do |t|
      t.string :recipient_name
      t.string :recipient_email
      t.string :name
      t.string :email
      t.string :phone
      t.text :message
      t.timestamps
    end
  end
  
  def self.down
    drop_table :inquiries
  end
end
