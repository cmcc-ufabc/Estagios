class AddAlunoIdToAprovas < ActiveRecord::Migration
  def change
     add_column :aprovas, :aluno_id, :string
  end
end
