class AddDocenteToDisciplinas < ActiveRecord::Migration
  def change
    add_column :disciplinas, :docente, :string
  end
end
