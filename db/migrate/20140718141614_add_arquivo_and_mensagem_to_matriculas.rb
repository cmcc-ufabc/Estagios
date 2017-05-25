class AddArquivoAndMensagemToMatriculas < ActiveRecord::Migration
  def change
    add_column :matriculas, :arquivo, :string
    add_column :matriculas, :mensagem, :text
  end
end
