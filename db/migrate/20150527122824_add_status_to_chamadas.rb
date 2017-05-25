class AddStatusToChamadas < ActiveRecord::Migration
  def change
    add_column :chamadas, :status, :string
  end
end
