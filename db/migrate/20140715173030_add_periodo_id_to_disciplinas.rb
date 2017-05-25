class AddPeriodoIdToDisciplinas < ActiveRecord::Migration
  def change
    add_column :disciplinas, :periodo_id, :integer
  end
end
