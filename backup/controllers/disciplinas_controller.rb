class DisciplinasController < ApplicationController
  # GET /disciplinas
  # GET /disciplinas.json
  before_filter :authenticate_usuario!#, :except=>[:show]
  def index
    unless possui_acesso?()
      return
    end
    
    @periodo = Periodo.find(:last)
    unless @periodo.blank?
      # = "O período de cadastro/edição de disciplinas não está ativo ( "+@periodo.cadastro_inicio+" até "+@periodo.cadastro_fim
      @disciplinas = Disciplina.find(:all, :conditions => {:periodo_id => @periodo.id}, :order => "nome")
      @titulo = "Disciplinas ofertadas para o "+@periodo.quadrimestre.to_s+" de "+@periodo.ano.to_s+" pelo "+current_usuario.centro.to_s
    else
      @titulo = t(:semperiodo) #"Nenhum período cadastrado"
    end
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @disciplinas }
    end
  end

  # GET /disciplinas/1
  # GET /disciplinas/1.json
  def show
    unless possui_acesso?()
      return
    end
    @disciplina = Disciplina.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @disciplina }
    end
  end

  # GET /disciplinas/new
  # GET /disciplinas/new.json
  def new
    unless possui_acesso?()
      return
    end
    @disciplina = Disciplina.new
    
    if current_usuario.centro == "CMCC"
      $cursos = [[t(:lic_matematica)]]
      
    elsif current_usuario.centro == "CCNH"
      $cursos = [[t(:lic_ciencia_bio)],[t(:lic_filosofia)],[t(:lic_quimica)],[t(:lic_fisica)]]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @disciplina }
    end
  end

  # GET /disciplinas/1/edit
  def edit
    unless possui_acesso?()
      return
    end
    @disciplina = Disciplina.find(params[:id])
    @matriculas = Matricula.find(:all, :conditions => {:disciplina_id => @disciplina.id})
    
    if current_usuario.centro == "CMCC"
      $cursos = [[t(:lic_matematica)]]
      
    elsif current_usuario.centro == "CCNH"
      $cursos = [[t(:lic_ciencia_bio)],[t(:lic_filosofia)],[t(:lic_quimica)],[t(:lic_fisica)]]
    end
    
  end

  # POST /disciplinas
  # POST /disciplinas.json
  def create
    unless possui_acesso?()
      return
    end
    @disciplina = Disciplina.new(params[:disciplina])
    @disciplina.periodo_id = Periodo.find(:last).id

    respond_to do |format|
      if @disciplina.save
        format.html { redirect_to @disciplina, notice: 'Disciplina criada com sucesso.' }
        format.json { render json: @disciplina, status: :created, location: @disciplina }
      else
        format.html { render action: "new" }
        format.json { render json: @disciplina.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /disciplinas/1
  # PUT /disciplinas/1.json
  def update
    unless possui_acesso?()
      return
    end
    @disciplina = Disciplina.find(params[:id])

    respond_to do |format|
      if @disciplina.update_attributes(params[:disciplina])
        
        @matriculas = Matricula.find(:all, :conditions => {:disciplina_id => @disciplina.id})
        @matriculas.each do |matricula|
          #avisa aos alunos, caso existam, que houveram alterações na disciplina
          UserMailer.disciplina_editada(matricula).deliver
        end
        
        format.html { redirect_to @disciplina, notice: 'Disciplina atualizada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @disciplina.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disciplinas/1
  # DELETE /disciplinas/1.json
  def destroy
    unless possui_acesso?()
      return
    end
    @disciplina = Disciplina.find(params[:id])
    @disciplina.destroy

    respond_to do |format|
      format.html { redirect_to disciplinas_url }
      format.json { head :no_content }
    end
  end
  
    def delete
    unless possui_acesso?()
      return
    end
    @disciplina = Disciplina.find(params[:id])
    @disciplina.destroy

    respond_to do |format|
      format.html { redirect_to disciplinas_url }
      format.json { head :no_content }
    end
  end
end
