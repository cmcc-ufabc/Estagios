class AddRemanescenteToPeriodos < ActiveRecord::Migration
  def change
    add_column :periodos, :remanescente_inicio, :date
    add_column :periodos, :remanescente_fim, :date
  end
end
