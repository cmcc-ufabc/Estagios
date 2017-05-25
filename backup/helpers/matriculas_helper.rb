module MatriculasHelper
  

  
  def mensagem_disponivel(matricula_id)
    retornar = false
    @matricula = Matricula.find(matricula_id)
    
    arquivo = @matricula.arquivo.file
    
    unless arquivo.blank?
        nome = @matricula.arquivo.file.identifier
    
        if nome != nil or nome != ''
            retornar = true
        end
    
    end
    
    unless @matricula.mensagem.blank?
      retornar = true
    end
    
    retornar
    
  end
  
  def arquivo_anexo(matricula_id)
    retornar = false
    @matricula = Matricula.find(matricula_id)
    
    arquivo = @matricula.arquivo.file
    
    unless arquivo.blank?
        nome = @matricula.arquivo.file.identifier
    
        if nome != nil or nome != ''
            retornar = true
        end
    
    end  
    
    retornar
        
    
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
  
  def disciplina_escolhida(id_da_disciplina) 
    #inicia o checkbox se o aluno escolheu a disciplina
    @matricula = Matricula.find(:first, :conditions =>{:disciplina_id => id_da_disciplina,  :aluno_id => current_usuario.id})
    if @matricula.blank?
      return false
    else
      return true
    end
  end
  
  def retorna_horario_disciplina(id_do_periodo)
    #@periodo = Periodo
  end
  
  def retorna_nome_aluno(id_do_aluno)
    @aluno = Usuario.find(id_do_aluno).nome
  end
  
  def retorna_ra(id_do_aluno)
    @aluno = Usuario.find(id_do_aluno).ra
  end  
  
  def retorna_email(id_do_aluno)
    @aluno = Usuario.find(id_do_aluno).email
  end
  
  
  def retorna_codigo(id_da_disciplina)
    @disciplina = Disciplina.find(id_da_disciplina) 
    if @disciplina.blank?
      @retornar = "-"
    else
      @retornar = @disciplina.codigo
    end
    
  end
  
 def retorna_nome_disciplina(id_da_disciplina)
    @disciplina = Disciplina.find(id_da_disciplina) 
    
    if @disciplina.blank?
      @retornar = "-"
    else
      @retornar = @disciplina.nome
    end
  end
  
    
  
    def retorna_turno(id_da_disciplina)
    @disciplina = Disciplina.find(id_da_disciplina) 
    
    if @disciplina.blank?
      @retornar = "-"
    else
      @retornar = @disciplina.turno
    end
  end
  
    def retorna_dia(id_da_disciplina)
    @disciplina = Disciplina.find(id_da_disciplina) 
    
    if @disciplina.blank?
      @retornar = "-"
    else
      @retornar = @disciplina.dia
    end
  end
  
    def retorna_horario_inicio(id_da_disciplina)
    @disciplina = Disciplina.find(id_da_disciplina) 
    
    if @disciplina.blank?
      @retornar = "-"
    else
      @retornar = @disciplina.horario_inicio
    end
  end
  
  def retorna_horario_fim(id_da_disciplina)
    @disciplina = Disciplina.find(id_da_disciplina) 
    
    if @disciplina.blank?
      @retornar = "-"
    else
      @retornar = @disciplina.horario_fim
    end
  end
  
  def retorna_periodo_letivo(id_da_disciplina)
      @disciplina = Disciplina.find(id_da_disciplina)
      @periodo = Periodo.find(@disciplina.periodo_id)
      
      @retornar = @periodo.quadrimestre.to_s+" de "+@periodo.ano.to_s    
  end  
  
    
  
end
