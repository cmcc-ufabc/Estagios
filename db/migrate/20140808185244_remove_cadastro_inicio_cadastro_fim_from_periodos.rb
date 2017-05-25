class RemoveCadastroInicioCadastroFimFromPeriodos < ActiveRecord::Migration
  def up
    remove_column :periodos, :cadastro_inicio
    remove_column :periodos, :cadastro_fim
  end

  def down
    add_column :periodos, :cadastro_inicio, :date
    add_column :periodos, :cadastro_fim, :date
  end
end
