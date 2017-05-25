class DssirelatoriosController < ApplicationController
  # GET /dssirelatorios
  # GET /dssirelatorios.json
  def index
    @dssirelatorios = Dssirelatorio.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dssirelatorios }
    end
  end

  # GET /dssirelatorios/1
  # GET /dssirelatorios/1.json
  def enviados
    @agora=Matricula.find(:first,:conditions=>{:periodo_id=> params[:id],:numero_ci=> params[:ci]})
    @agora.horas
    if @agora.horas == nil
      @data= '-'
    else
      @data = @agora.horas
    end
    @teste=params[:id]
  end
  
  def show

    @teste=params[:id]
 @numero_ci= Matricula.find(:all,:conditions=>{:periodo_id=>params[:id]})
 @matrizci=Array.new
 @numero_ci.each do|numeroci|
 if numeroci == nil
 else
 @matrizci.append(numeroci.numero_ci)
 @matriz=@matrizci.uniq
 end
 end
 
  
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dssirelatorio }
    end
  end
 
  

  # GET /dssirelatorios/new
  # GET /dssirelatorios/new.json
  def new
    @dssirelatorio = Dssirelatorio.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dssirelatorio }
    end
  end

  # GET /dssirelatorios/1/edit
  def edit
    @dssirelatorio = Dssirelatorio.find(params[:id])
  end

  # POST /dssirelatorios
  # POST /dssirelatorios.json
  def create
    @dssirelatorio = Dssirelatorio.new(params[:dssirelatorio])

    respond_to do |format|
      if @dssirelatorio.save
        format.html { redirect_to @dssirelatorio, notice: 'Dssirelatorio was successfully created.' }
        format.json { render json: @dssirelatorio, status: :created, location: @dssirelatorio }
      else
        format.html { render action: "new" }
        format.json { render json: @dssirelatorio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dssirelatorios/1
  # PUT /dssirelatorios/1.json
  def update
    @dssirelatorio = Dssirelatorio.find(params[:id])

    respond_to do |format|
      if @dssirelatorio.update_attributes(params[:dssirelatorio])
        format.html { redirect_to @dssirelatorio, notice: 'Dssirelatorio was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dssirelatorio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dssirelatorios/1
  # DELETE /dssirelatorios/1.json
  def destroy
    @dssirelatorio = Dssirelatorio.find(params[:id])
    @dssirelatorio.destroy

    respond_to do |format|
      format.html { redirect_to dssirelatorios_url }
      format.json { head :no_content }
    end
  end
end
