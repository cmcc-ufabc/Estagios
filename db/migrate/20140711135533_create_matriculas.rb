class CreateMatriculas < ActiveRecord::Migration
  def change
    create_table :matriculas do |t|
      t.integer :disciplina_id
      t.integer :aluno_id
      t.integer :periodo_id
      t.integer :situacao

      t.timestamps
    end
  end
end
