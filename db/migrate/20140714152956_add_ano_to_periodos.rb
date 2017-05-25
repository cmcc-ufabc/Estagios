class AddAnoToPeriodos < ActiveRecord::Migration
  def change
    add_column :periodos, :quadrimestre, :string
    add_column :periodos, :ano, :integer
  end
end
