class AddCadastroToPeriodos < ActiveRecord::Migration
  def change
    add_column :periodos, :cadastro_inicio, :date
    add_column :periodos, :cadastro_fim, :date
  end
end
