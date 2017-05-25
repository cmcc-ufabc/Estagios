module DisciplinasHelper
  
  def filtro_centro(disciplina_id)
    #checa se a disciplina é do centro
    @retornar = false    
    @disciplina = Disciplina.find(disciplina_id)
    
    if current_usuario.centro == "CMCC"
      
        if @disciplina.curso == t(:lic_matematica) or @disciplina.curso == "CMCC" #"Licenciatura em matemática"            
            @retornar = true
        
        end
    elsif current_usuario.centro == "CCNH"
      
        if @disciplina.curso == t(:lic_ciencia_bio) or @disciplina.curso == t(:lic_fisica) or @disciplina.curso == t(:lic_quimica) or @disciplina.curso == t(:lic_filosofia) or @disciplina.curso == "CCNH" #Licenciatura em ciencias biologicas, física, química ou filosofia
            @retornar = true
        end

    end
    
    @retornar
  end
  
  def concatena(id)
    @disciplina = Disciplina.find(id)
    @link = "localhost:3000/delete/disciplina"+@disciplina.id.to_string
  end
  
  def retorna_nome_aluno(aluno_id)
    @aluno = Usuario.find(aluno_id).nome
  end
  
  def retorna_email_aluno(aluno_id)
    @aluno = Usuario.find(aluno_id).email
  end  
  
  def retorna_telefone_aluno(aluno_id)
    @aluno = Usuario.find(aluno_id).telefone
  end   
end
