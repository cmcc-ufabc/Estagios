class AddProtocoloToChamadas < ActiveRecord::Migration
  def change
    add_column :chamadas, :protocolo, :string
  end
end
