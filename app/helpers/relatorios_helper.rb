module RelatoriosHelper
  
  def filtro_aluno(aluno_id)
    @aluno = Usuario.find(aluno_id)
    retornar = true
    
    $alunos.each do |aluno|
      if @aluno.ra == aluno
        retornar = false
      end
    end
    
    $alunos.append(@aluno.ra)
    retornar
  end  
  
  
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
  def retorna_materia(id)
    @nome=Disciplina.find(:first,:conditions=>{:id=>id})
    @nome.nome
  end
   def retorna_aluno(id)
    @antes=Matricula.find(:first,:conditions=>{:id=>id})
    @nome=Usuario.find(:first,:conditions=>{:id=>@antes.aluno_id})
    @nome.nome
  end
   def retorna_ra_aluno(id)
    @antes=Matricula.find(:first,:conditions=>{:id=>id})
    @ra=Usuario.find(:first,:conditions=>{:id=>@antes.aluno_id})
    @ra.ra
  end
  def retorna_email(id)
    @antes=Matricula.find(:first,:conditions=>{:id=>id})
    @email=Usuario.find(:first,:conditions=>{:id=>@antes.aluno_id})
    @email.email
  end
   def retorna_telefone(id)
    @antes=Matricula.find(:first,:conditions=>{:id=>id})
    @fone=Usuario.find(:first,:conditions=>{:id=>@antes.aluno_id})
    @fone.telefone
  end

    def retorna_turno(id)
    @turno=Disciplina.find(:first,:conditions=>{:id=>id})
    @turno.turno
  end
  def retorna_parecer(id)
    @antes=Matricula.find(:first,:conditions=>{:id=>id})
    @antes.parecer
  end
  def retorna_docente(id)
    @antes=Matricula.find(:first,:conditions=>{:id=>id})
    @nome=Disciplina.find(:first,:conditions=>{:id=>@antes.disciplina_id})
    @nome.docente
  end
end
