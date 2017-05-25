class ChangeResposta6FormatInFormularios < ActiveRecord::Migration
  def change
    add_column :formularios, :resposta_7, :string
  end
end

