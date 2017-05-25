class CreateCursos < ActiveRecord::Migration
  def change
    create_table :cursos do |t|
      t.integer :aluno_id
      t.string :curso

      t.timestamps
    end
  end
end
