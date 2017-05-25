module FluxomatriculasHelper
  def retorna_nome(aluno_id)
    @aluno= Usuario.find_by_id(aluno_id)
    @aluno.nome
  end
end
