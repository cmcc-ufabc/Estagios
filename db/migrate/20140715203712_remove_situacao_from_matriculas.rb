class RemoveSituacaoFromMatriculas < ActiveRecord::Migration
  def up
    remove_column :matriculas, :situacao
  end

  def down
    add_column :matriculas, :situacao, :string
  end
end
