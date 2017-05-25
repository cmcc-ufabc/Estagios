module ConceitosHelper
  
  def retorna_periodo_dssi(periodo)
      @retornar = "desconhecido"
    if periodo.quadrimestre == t(:q1)
      @retornar = periodo.ano.to_s+"."+1.to_s
    elsif periodo.quadrimestre == t(:q2)
      @retornar = periodo.ano.to_s+"."+2.to_s
    elsif periodo.quadrimestre == t(:q3)
      @retornar = periodo.ano.to_s+"."+3.to_s
    end
    
    @retornar
  end
  
  def retorna_nome_aluno(id_do_aluno)
    @aluno = Usuario.find(id_do_aluno).nome
  end
  
  def retorna_ra(id_do_aluno)
    @aluno = Usuario.find(id_do_aluno).ra
  end    
  
  def retorna_nome_disciplina(id_da_disciplina)
    @disciplina = Disciplina.find(id_da_disciplina).nome    
  end
  
  def retorna_codigo(id_da_disciplina)
    @disciplina = Disciplina.find(id_da_disciplina).codigo
  end
  
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
end
