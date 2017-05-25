class CreateChamadas < ActiveRecord::Migration
  def change
    create_table :chamadas do |t|
      t.string :aluno_id
      t.text :mensagem_sec
      t.text :mensagem_aluno
      t.string :tipo_chamada

      t.timestamps
    end
  end
end
