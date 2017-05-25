class AddAlunoIdToFormularios < ActiveRecord::Migration
  def change
    add_column :formularios, :aluno_id, :integer
    add_column :formularios, :periodo_id, :integer
    add_column :formularios, :centro, :string
  end
end
