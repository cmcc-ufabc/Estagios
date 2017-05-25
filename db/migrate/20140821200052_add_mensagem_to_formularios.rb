class AddMensagemToFormularios < ActiveRecord::Migration
  def change
    add_column :formularios, :mensagem, :text
  end
end
