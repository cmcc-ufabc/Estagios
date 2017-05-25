class FluxomatriculasController < ApplicationController
  # GET /fluxomatriculas
  # GET /fluxomatriculas.json
  def index
    @fluxomatriculas = Fluxomatricula.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fluxomatriculas }
    end
  end

  # GET /fluxomatriculas/1
  # GET /fluxomatriculas/1.json
  def show
    @fluxomatricula = Fluxomatricula.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fluxomatricula }
    end
  end

  # GET /fluxomatriculas/new
  # GET /fluxomatriculas/new.json
  def new
    @fluxomatricula = Fluxomatricula.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fluxomatricula }
    end
  end

  # GET /fluxomatriculas/1/edit
  def edit
    @fluxomatricula = Fluxomatricula.find(params[:id])
  end

  # POST /fluxomatriculas
  # POST /fluxomatriculas.json
  def create
    @fluxomatricula = Fluxomatricula.new(params[:fluxomatricula])

    respond_to do |format|
      if @fluxomatricula.save
        format.html { redirect_to @fluxomatricula, notice: 'Fluxomatricula was successfully created.' }
        format.json { render json: @fluxomatricula, status: :created, location: @fluxomatricula }
      else
        format.html { render action: "new" }
        format.json { render json: @fluxomatricula.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fluxomatriculas/1
  # PUT /fluxomatriculas/1.json
  def update
    @fluxomatricula = Fluxomatricula.find(params[:id])

    respond_to do |format|
      if @fluxomatricula.update_attributes(params[:fluxomatricula])
        format.html { redirect_to @fluxomatricula, notice: 'Fluxomatricula was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fluxomatricula.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fluxomatriculas/1
  # DELETE /fluxomatriculas/1.json
  def destroy
    @fluxomatricula = Fluxomatricula.find(params[:id])
    @fluxomatricula.destroy

    respond_to do |format|
      format.html { redirect_to fluxomatriculas_url }
      format.json { head :no_content }
    end
  end
end
