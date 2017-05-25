class PeriodosController < ApplicationController
  # GET /periodos
  # GET /periodos.json
  before_filter :authenticate_usuario!#, :except=>[:show]
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

  # GET /periodos/1
  # GET /periodos/1.json
  def show
    unless possui_acesso?()
      return
    end
    @periodo = Periodo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @periodo }
    end
  end

  # GET /periodos/new
  # GET /periodos/new.json
  def new
    unless possui_acesso?()
      return
    end
    @periodo = Periodo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @periodo }
    end
  end

  # GET /periodos/1/edit
  def edit
    unless possui_acesso?()
      return
    end
    @periodo = Periodo.find(params[:id])
  end

  # POST /periodos
  # POST /periodos.json
  def create
    unless possui_acesso?()
      return
    end
    @periodos = Periodo.all
    @periodo = Periodo.new(params[:periodo])
    @periodo.registrador_ci = 0

    respond_to do |format|     
      
      if @periodo.save
        
        unless @periodos.blank?
          i = @periodos.length
          @disciplinas = Disciplina.find(:all, :conditions => {:periodo_id => @periodos[i-1].id})
          @disciplinas.each do |disc|
            @new_disciplina = Disciplina.new :curso => disc.curso, :codigo => disc.codigo, :nome => disc.nome,
              :turno => disc.turno, :dia => disc.dia, :horario_inicio => disc.horario_inicio, 
              :horario_fim => disc.horario_fim
            @new_disciplina.periodo_id = Periodo.find(:last).id
            @new_disciplina.save
          end
        end
        
        
        format.html { redirect_to @periodo, notice: 'Periodo criado com sucesso.' }
        format.json { render json: @periodo, status: :created, location: @periodo }
      else
        format.html { render action: "new" }
        format.json { render json: @periodo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /periodos/1
  # PUT /periodos/1.json
  def update
    unless possui_acesso?()
      return
    end
    @periodo = Periodo.find(params[:id])

    respond_to do |format|
      if @periodo.update_attributes(params[:periodo])       
        
        
        format.html { redirect_to @periodo, notice: 'Periodo atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @periodo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /periodos/1
  # DELETE /periodos/1.json
  def delete
    unless possui_acesso?()
      return
    end
    @periodo = Periodo.find(params[:id])
    @matriculas = Matricula.find(:all, :conditions =>{:periodo_id => @periodo.id})
    @matriculas.each do |matricula|
      matricula.destroy
    end
    
    
    @disciplinas = Disciplina.find(:all, :conditions =>{:periodo_id => @periodo.id})
    @disciplinas.each do |disciplina|
      disciplina.destroy
    end   

    @periodo.destroy
    respond_to do |format|
      format.html { redirect_to periodos_url }
      format.json { head :no_content }
    end
  end
end
