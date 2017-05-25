module ChamadasHelper
  
  def retorna_nome_aluno(id)
    @retorna=Usuarios.find(:first,:conditions=>{:id=>id})
    @retorna.nome
  end
  
end
