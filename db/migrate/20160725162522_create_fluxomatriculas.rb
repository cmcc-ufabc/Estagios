class CreateFluxomatriculas < ActiveRecord::Migration
  def change
    create_table :fluxomatriculas do |t|
      t.string :aluno_id
      t.string :periodo_id
      t.string :disciplina_id
      t.string :data

      t.timestamps
    end
  end
end
