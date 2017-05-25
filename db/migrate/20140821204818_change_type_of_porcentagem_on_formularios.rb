class ChangeTypeOfPorcentagemOnFormularios < ActiveRecord::Migration
  def up
    change_column :formularios, :porcentagem, :string
  end

  def down
    change_column :formularios, :porcentagem, :integer
  end
end
