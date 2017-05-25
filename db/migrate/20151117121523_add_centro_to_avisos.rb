class AddCentroToAvisos < ActiveRecord::Migration
  def change
     add_column :avisos, :centro, :string
  end
end
