class RelatoriosController < ApplicationController
  
  before_filter :authenticate_usuario!, :except=>[:view]
  before_filter :authenticate_usuario!, :except => [:unificado]
  prawnto :prawn => {:page_size   => "A4"}

  def detalhes
    
    unless possui_acesso?()
      return
    end
      @matri= Matricula.find(:all, :conditions => {:periodo_id => params[:periodo], :aluno_id => params[:aluno_id], :status => [1,10]})
      @aluno = Usuario.find(params[:aluno_id])
      @cursos = Curso.find(:all, :conditions => {:aluno_id => params[:aluno_id]})
      @matriculas = Matricula.find(:all, :conditions => {:periodo_id => params[:periodo], :aluno_id => params[:aluno_id], :status => [-1,1,2,3]})
      @formulario = Formulario.find(:first, :conditions => {:periodo_id => params[:periodo], :aluno_id => params[:aluno_id], :centro => current_usuario.centro})
  end
  
  def envio
    unless possui_acesso?()
      return
    end
    @lista_recebida = params[:lista].to_a
    
    case params[:curso]
      when "bio"       
        @curso = t(:lic_ciencia_bio)
        
      when "filo"        
        @curso = t(:lic_filosofia)
        
      when "fis"        
        @curso = t(:lic_fisica)
        
      when "mat"        
        @curso = t(:lic_matematica)
        
      when "qui"        
        @curso = t(:lic_quimica)     
    end
    
    @disciplina = Disciplina.find(:first, :conditions => {:periodo_id => params[:periodo], :curso => @curso, :codigo => params[:codigo]})
    @emails = @lista_recebida[0][1].split(';')     
    @emails.each do |email|

      UserMailer.relatorio_matriculas(email,@disciplina,Usuario.find(current_usuario.id)).deliver
      
    end
      flash[:notice] = t(:emailenviado)
      redirect_to :back
      
  end
  
  def envio2
    unless possui_acesso?()
      return
    end
    @lista_recebida = params[:lista].to_a
    
    @emails = @lista_recebida[0][1].split(';')     
    @emails.each do |email|
    @periodo=(params[:id])
    @centro=current_usuario.centro
      UserMailer.relatorio_matricula2(email,@periodo,@centro).deliver
      
    end
    flash[:notice] = t(:emailenviado)
      redirect_to :back
  end
  
  def view
    @curso = params[:curso]
    
    case @curso
      when "bio"       
        @retornar = t(:lic_ciencia_bio)
        
      when "filo"        
        @retornar = t(:lic_filosofia)
        
      when "fis"        
        @retornar = t(:lic_fisica)
        
      when "mat"        
        @retornar = t(:lic_matematica)
        
      when "qui"        
        @retornar = t(:lic_quimica)     
    end
    
    @disciplinas = Disciplina.find(:all, :conditions =>{:codigo => params[:codigo], :periodo_id => params[:periodo], :curso => @retornar})
    
    #retorna os ids das disciplinas
    @ids = [nil]
    @disciplinas.each do |disciplina|
      @ids.append(disciplina.id)
    end
    
    @matri= Matricula.find(:all, :conditions =>{:disciplina_id => @ids, :status => [10]}, :order => "aluno_id")
    @periodo = Periodo.find(params[:periodo])
    @matriculas = Matricula.find(:all, :conditions =>{:disciplina_id => @ids, :status => [-1,1,2,3]}, :order => "aluno_id")
    @agora = Time.now
    
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
    $disciplinas_amostradas = [[nil,nil]]
    
    @periodo = Periodo.find(params[:id])
    unless @periodo.blank?
	  @matriculas = Matricula.find(:all, :conditions => {:periodo_id => @periodo.id, :status => [-1,1,2,3]}, :order => 'aluno_id')
      @matricular = Matricula.find(:all, :conditions => {:periodo_id => @periodo.id, :status => [-1,1,2,3,10],:centro=>current_usuario.centro}, :order => 'aluno_id')
      @matriz=[]
      @matricular.each do |matricula|
        @matriz.push(matricula.aluno_id)
      end
      @matriz.each do |matriz|
      @usuario=Usuario.find(:all,:conditions=>{:id=>@matriz},:order=> 'nome')
      end
	 
	  
      @matri= Matricula.find(:all, :conditions => {:periodo_id => @periodo.id, :status => [10]}, :order => 'aluno_id')
	  
	  
      #armazena os RAs dos alunos, para que cada um seja mostrado apenas uma vez      
      $alunos = [[nil]]
      
      @disciplinas = Disciplina.find(:all, :conditions => {:periodo_id => params[:id]}, :order => "curso")
      @titulo = "Disciplinas ofertadas para o "+@periodo.quadrimestre.to_s+" de "+@periodo.ano.to_s+" pelo "+current_usuario.centro.to_s
    else
      @titulo = t(:semperiodo) #"Nenhum periodo cadastrado"
    end
    @tre = 4
    
  end
end
