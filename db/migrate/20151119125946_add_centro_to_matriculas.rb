class AddCentroToMatriculas < ActiveRecord::Migration
  def change
    add_column :matriculas, :centro, :string
  end
end
