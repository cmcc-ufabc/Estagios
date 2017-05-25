class AddCentroToCancelamentos < ActiveRecord::Migration
  def change
    add_column :cancelamentos, :centro, :string
  end
end
