class ConceitosController < ApplicationController
  
  before_filter :authenticate_usuario!, :except=>[:dssi]
  
  def relatorio
    unless possui_acesso?()
      return
    end
    @agora = Time.now
    @curso = nil
    @periodo = Periodo.find(params[:periodo])
    if params[:curso] == 'bio'
      @curso = t(:lic_ciencia_bio)
    elsif params[:curso] == 'fil' 
      @curso = t(:lic_filosofia)
    elsif params[:curso] == 'fis'
      @curso = t(:lic_fisica)
    elsif params[:curso] == 'mat'
      @curso = t(:lic_matematica)
    elsif params[:curso] == 'qui'
      @curso = t(:lic_quimica)
    end
    
     
    @matriculas = Matricula.find(:all, :conditions => {:status => 3, :periodo_id => @periodo.id}, :order => "aluno_id")

  end
  
  
  def dssi
    
    @periodo = Periodo.find(params[:periodo])
    @matriculas = Matricula.find(:all, :conditions => {:periodo_id => params[:periodo], :numero_ci => params[:ci]}, :order => "aluno_id")
    
    @tabela = Array.new
   
    @matriculas.each do |matricula|
      linha = Tabela.new
      linha.nome = retorna_nome_aluno(matricula.aluno_id)
      linha.ra = retorna_ra(matricula.aluno_id)
      linha.disciplina = retorna_nome_disciplina(matricula.disciplina_id)
      linha.codigo = retorna_codigo(matricula.disciplina_id)
      linha.parecer = matricula.conceito
      linha.quadrimestre = retorna_periodo_dssi(@periodo)
      
      @tabela.append(linha)
    end  

  respond_to do |format|
    format.html
    format.xls do
      render :xls => @tabela,
                     :columns => [ :nome, :ra, :disciplina, :codigo, :parecer, :quadrimestre ],
                     :headers => %w[ Nome RA Disciplina Codigo Parecer Quadrimestre]
    end
  end

    

end  

  def modelo_email
    unless possui_acesso?()
      return
    end
      curso = params[:curso]
      @periodo = Periodo.find(params[:periodo])
      @periodo.registrador_ci = (@periodo.registrador_ci+1)
      @periodo.save
      @tabela = Array.new
      @curso = "desconhecido"
      
    if curso == "mat"
      @curso = t(:lic_matematica)
    elsif curso == "bio"  
      @curso = t(:lic_ciencia_bio)
    elsif curso == "fil"
      @curso = t(:lic_filosofia)
    elsif curso == "qui"
      @curso = t(:lic_quimica)
    elsif curso == "fis"
      @curso = t(:lic_fisica)
    end
      
      @matriculas = Matricula.find(:all, :conditions => {:periodo_id => @periodo.id, :status => 2}, :order => "disciplina_id")
       

          @matriculas.each do |matricula|
              disciplina = Disciplina.find(matricula.disciplina_id)
              if disciplina.curso == @curso
                  matricula.status = 3
                  matricula.numero_ci = @periodo.registrador_ci
                  matricula.save
              end
      
          end
          UserMailer.modelo_ci(@curso,@periodo,current_usuario).deliver
          #UserMailer.modelo_ci(@tabela,@curso,@periodo,current_usuario).deliver
      flash[:notice] = t(:emailenviado) #conceito enviado com sucesso"
      redirect_to :back
  end
  
  def envio  
    unless possui_acesso?()
      return
    end
    @matricula = Matricula.find(params[:id])
    @disciplina = Disciplina.find(@matricula.disciplina_id)
    @horas = ((@disciplina.horario_fim - @disciplina.horario_inicio)/ 1.hour).round
    
    if @matricula.update_attributes(params[:conceito])
      flash[:notice] = t(:conceito_enviado) #conceito enviado com sucesso"
    else
      flash[:erro] = t(:erro_conceito) #houve um erro em sua solicitações
    end
    
    redirect_to :back
  end
  
  def index
    unless possui_acesso?()
      return
    end
    @periodos = Periodo.all
    @periodos.reverse!

    
    
    
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @periodos }
    end
  end

  def show    
    unless possui_acesso?()
      return
    end
    @periodo = Periodo.find(params[:id])
    unless @periodo.blank?
      
      
      @matriculas = Matricula.find(:all, :conditions => {:periodo_id => params[:id], :status => 1}, :order => "disciplina_id")
      @titulo = "Matriculas realizadas em disciplinas ofertadas pelo "+current_usuario.centro.to_s+" no "+@periodo.quadrimestre.to_s+" de "+@periodo.ano.to_s
    else
      @titulo = t(:semperiodo) #"Nenhum período cadastrado"
    end
    
      @matriculas_aux = Matricula.find(:all, :conditions => {:periodo_id => params[:id], :status => 2}, :order => "aluno_id")
          @lic_ciencia_bio = Array.new
          @lic_filosofia = Array.new
          @lic_fisica = Array.new
          @lic_quimica = Array.new
          @lic_matematica = Array.new
    
      if current_usuario.centro == "CMCC"          
          
          @matriculas_aux.each do |matricula|
              disciplina = Disciplina.find(matricula.disciplina_id)
              
              if disciplina.curso == t(:lic_matematica)
                  @lic_matematica.append(matricula)
                  
              end
        
          end
      elsif current_usuario.centro == "CCNH"
        
          @matriculas_aux.each do |matricula|
              disciplina = Disciplina.find(matricula.disciplina_id)
              
              if disciplina.curso == t(:lic_ciencia_bio)
                  @lic_ciencia_bio.append(matricula)
              elsif disciplina.curso == t(:lic_filosofia)
                  @lic_filosofia.append(matricula)
              elsif disciplina.curso == t(:lic_fisica) 
                  @lic_fisica.append(matricula)
              elsif disciplina.curso == t(:lic_quimica)
                  @lic_quimica.append(matricula)
              end
        
          end

      
      end

      
  end
end
