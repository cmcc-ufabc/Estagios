class ChamadasController < ApplicationController
  # GET /chamadas
  # GET /chamadas.json
  def index
    if current_usuario.tipo == "Aluno"
     @chamadas = Chamada.find(:all,:conditions=>{:status=>'Aberto',:aluno_id=>current_usuario.id,:periodo_id=>params[:id]})
    else
      @chamadas = Chamada.find(:all,:conditions=>{:status=>'Aberto',:periodo_id=>params[:id]})
    end
    if current_usuario.tipo == "Aluno"
     @chamadasen = Chamada.find(:all,:conditions=>{:status=>'Fechado',:aluno_id=>current_usuario.id,:periodo_id=>params[:id]})
    else
      @chamadasen = Chamada.find(:all,:conditions=>{:status=>'Fechado',:periodo_id=>params[:id]})
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chamadas }
    end
  end

  # GET /chamadas/1
  # GET /chamadas/1.json
  def show
    @chamada = Chamada.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chamada }
    end
  end

  # GET /chamadas/new
  # GET /chamadas/new.json
  def new
    @chamada = Chamada.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chamada }
    end
  end

  # GET /chamadas/1/edit
  def edit
    @chamada = Chamada.find(params[:id])
  end

  # POST /chamadas
  # POST /chamadas.json
  def create
    @chamada = Chamada.new(params[:chamada])

    respond_to do |format|
      if @chamada.save
        format.html { redirect_to @chamada, notice: 'Chamada was successfully created.' }
        format.json { render json: @chamada, status: :created, location: @chamada }
      else
        format.html { render action: "new" }
        format.json { render json: @chamada.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /chamadas/1
  # PUT /chamadas/1.json
  def update
    @chamada = Chamada.find(params[:id])

    respond_to do |format|
      if @chamada.update_attributes(params[:chamada])
        format.html { redirect_to @chamada, notice: 'Chamada was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chamada.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chamadas/1
  # DELETE /chamadas/1.json
  def destroy
    @chamada = Chamada.find(params[:id])
    @chamada.destroy

    respond_to do |format|
      format.html { redirect_to chamadas_url }
      format.json { head :no_content }
    end
  end
  
  def fecha
    @fechar=Chamada.find(:first,:conditions=>{:id=>params[:id]})
    if @fechar.status == 'Aberto'
      @fechar.update_attributes(:status=>'Fechado')
    end
    
    respond_to do |format|
      format.html { redirect_to chamadas_url, notice: 'Chamada encerrada' }
      format.json { head :no_content }
    end
  end
end
