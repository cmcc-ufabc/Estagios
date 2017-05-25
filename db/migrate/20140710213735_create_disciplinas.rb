class CreateDisciplinas < ActiveRecord::Migration
  def change
    create_table :disciplinas do |t|
      t.string :curso
      t.string :codigo
      t.string :nome
      t.string :turno
      t.string :dia
      t.time :horario_inicio
      t.time :horario_fim

      t.timestamps
    end
  end
end
