class AddPorcentagemToFormularios < ActiveRecord::Migration
  def change
    add_column :formularios, :porcentagem, :integer
  end
end
