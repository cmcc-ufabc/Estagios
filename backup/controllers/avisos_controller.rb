class AvisosController < ApplicationController
  # GET /avisos
  # GET /avisos.json
  
    before_filter :authenticate_usuario!, :except=>[:confirm]
  
    def confirm
      
    end
    
    def realizou_matricula()
      @periodo = Periodo.find(:last)
      unless @periodo.blank?
      
      @matriculas = Matricula.find(:all, :conditions => {:aluno_id => current_usuario.id, :periodo_id => @periodo.id})
      
      if @matriculas.blank?
          #não realizou matrícula no período atual
          return false
      else
          #realizou a matrícula no período atual
          return true
      end
        
      else
          return false
      end

  end
  

  def index
    
    @periodo = Periodo.find(:last)
    unless @periodo.blank?
    
        @realizou_matricula = false
        if current_usuario.tipo == "Aluno"
            if realizou_matricula()
                @realizou_matricula = true           
            
                @matriculas = Matricula.find(:all, :conditions => {:aluno_id => current_usuario.id, :periodo_id => Periodo.find(:last).id})
            end
        end
    @avisos = Aviso.find(:all, :conditions => {:periodo_id => @periodo.id})
    else
      @avisos = Aviso.all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @avisos }
    end
  end

  # GET /avisos/1
  # GET /avisos/1.json
  def show
    unless possui_acesso?()
      return
    end
    @aviso = Aviso.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @aviso }
    end
  end

  # GET /avisos/new
  # GET /avisos/new.json
  def new
    unless possui_acesso?()
      return
    end
    @aviso = Aviso.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @aviso }
    end
  end

  # GET /avisos/1/edit
  def edit
    unless possui_acesso?()
      return
    end
    @aviso = Aviso.find(params[:id])
  end

  # POST /avisos
  # POST /avisos.json
  def create
    unless possui_acesso?()
      return
    end
    
    @periodo = Periodo.find(:last)
    
    if @periodo.blank?
        flash[:erro] = t(:sem_periodo)
        redirect_to :back
        return
    end
    
    @aviso = Aviso.new(params[:aviso])
    @aviso.periodo_id = @periodo.id
    @hoje = Date.current
    @aviso.data = @hoje
    respond_to do |format|
      if @aviso.save
        format.html { redirect_to @aviso, notice: 'Aviso criado com sucesso.' }
        format.json { render json: @aviso, status: :created, location: @aviso }
      else
        format.html { render action: "new" }
        format.json { render json: @aviso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /avisos/1
  # PUT /avisos/1.json
  def update
    unless possui_acesso?()
      return
    end
    @aviso = Aviso.find(params[:id])

    respond_to do |format|
      if @aviso.update_attributes(params[:aviso])
        format.html { redirect_to @aviso, notice: 'Aviso was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @aviso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /avisos/1
  # DELETE /avisos/1.json
  def delete
    unless possui_acesso?()
      return
    end
    @aviso = Aviso.find(params[:id])
    @aviso.destroy

    respond_to do |format|
      format.html { redirect_to avisos_url }
      format.json { head :no_content }
    end
  end
end
