class AddResposta6ToFormularios < ActiveRecord::Migration
  def change
    add_column :formularios, :resposta_6, :string
  end
end
