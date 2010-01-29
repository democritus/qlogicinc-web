class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :name, :null => false
      t.string :permalink, :null => false
      t.text :content
      t.timestamps
    end
    
    add_index :pages, [:name], :name => 'name', :unique => true
    add_index :pages, [:permalink], :name => 'permalink', :unique => true
  end
  
  def self.down
    drop_table :pages
  end
end
