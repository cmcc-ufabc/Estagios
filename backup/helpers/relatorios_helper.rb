module RelatoriosHelper
  
  def retorna_abrev_curso(disciplina_id)
    @disciplina = Disciplina.find(disciplina_id)    
    
    case @disciplina.curso
      when t(:lic_ciencia_bio)
        @retornar = "bio"
        
      when t(:lic_filosofia)
        @retornar = "filo"
        
      when t(:lic_fisica)
        @retornar = "fis"
        
      when t(:lic_matematica)
        @retornar = "mat"
        
      when t(:lic_quimica)
        @retornar = "qui"      
    end
    @retornar
    
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
  
  def filtro_relatorio(disciplina_id)
    @disciplina = Disciplina.find(disciplina_id)
    @return = true
    $disciplinas_amostradas.each do |disciplina|
      if disciplina[0] == @disciplina.codigo and disciplina[1] == @disciplina.curso
          @return = false
          break
        end
    end
    
    $disciplinas_amostradas.append([@disciplina.codigo,@disciplina.curso])
    @return
    
  end
end
