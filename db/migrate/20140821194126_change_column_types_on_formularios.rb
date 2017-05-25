class ChangeColumnTypesOnFormularios < ActiveRecord::Migration
  def up

    change_column :formularios, :resposta_2, :string
    change_column :formularios, :resposta_3, :string
    change_column :formularios, :resposta_4, :string
    change_column :formularios, :resposta_5, :string
  end

  def down

    change_column :formularios, :resposta_2, :boolean
    change_column :formularios, :resposta_3, :boolean
    change_column :formularios, :resposta_4, :boolean
    change_column :formularios, :resposta_5, :boolean
  end
end
