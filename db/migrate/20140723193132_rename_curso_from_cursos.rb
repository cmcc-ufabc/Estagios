class RenameCursoFromCursos < ActiveRecord::Migration
  def up
    rename_column :cursos, :curso, :nome_do_curso
  end

  def down
  end
end
