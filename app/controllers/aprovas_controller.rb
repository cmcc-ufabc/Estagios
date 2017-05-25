class AprovasController < ApplicationController
  # GET /aprovas
  # GET /aprovas.json
  def index
    @aprovas = Aprova.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @aprovas }
    end
    
  end

  # GET /aprovas/1
  # GET /aprovas/1.json
  def show
    @aprova = Aprova.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @aprova }
    end
    
  end

  # GET /aprovas/new
  # GET /aprovas/new.json
  def new
    @aprova = Aprova.new

    
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @aprova }
    end
    
   
    end

  # GET /aprovas/1/edit
  def edit
    @aprova = Aprova.find(params[:id])
  end

  # POST /aprovas
  # POST /aprovas.json
  def create
    @aprova = Aprova.new(params[:aprova])

    respond_to do |format|
      if @aprova.save
        format.html { redirect_to @aprova, notice: 'Aprova was successfully created.' }
        format.json { render json: @aprova, status: :created, location: @aprova }
      else
        format.html { render action: "new" }
        format.json { render json: @aprova.errors, status: :unprocessable_entity }
      end
    end
    if current_usuario.centro == 'CMCC'
     if @aprova.tipo == 'Sim'
      @teste=Usuario.find(:first,:conditions=>{:tipo=>'Servidor (CMCC)',:id=>@aprova.aluno_id})
      @teste.update_attributes(:tipo=>'Administrador',:centro=>'CMCC')
     else
       @teste=Usuario.find(:first,:conditions=>{:tipo=>'Servidor (CMCC)',:id=>@aprova.aluno_id})
      @teste.update_attributes(:tipo=>'Aluno')
   end
    else
      if @aprova.tipo == 'Sim'
      @teste=Usuario.find(:first,:conditions=>{:tipo=>'Servidor (CCNH)',:id=>@aprova.aluno_id})
      @teste.update_attributes(:tipo=>'Administrador',:centro=>'CCNH')
     else
       @teste=Usuario.find(:first,:conditions=>{:tipo=>'Servidor(CCNH)',:id=>@aprova.aluno_id})
      @teste.update_attributes(:tipo=>'Aluno')
   end
    end
      
     
  end

  # PUT /aprovas/1
  # PUT /aprovas/1.json
  def update
    @aprova = Aprova.find(params[:id])

    respond_to do |format|
      if @aprova.update_attributes(params[:aprova])
        format.html { redirect_to @aprova, notice: 'Aprova was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @aprova.errors, status: :unprocessable_entity }
      end
    end
        if @aprova.tipo == 'Sim'
      @teste=Usuario.find(:first,:conditions=>{:tipo=>'Secretaria0',:id=>@aprova.aluno_id})
      @teste.update_attributes(:tipo=>'Secretaria')
    end
  end

  # DELETE /aprovas/1
  # DELETE /aprovas/1.json
  def destroy
    @aprova = Aprova.find(params[:id])
    @aprova.destroy

    respond_to do |format|
      format.html { redirect_to aprovas_url }
      format.json { head :no_content }
    end
  end
end
