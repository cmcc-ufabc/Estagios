class CancelamentosController < ApplicationController
  # GET /cancelamentos
  # GET /cancelamentos.json


  def index
    @cancelamentos = Cancelamento.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cancelamentos }
    end
  end

  # GET /cancelamentos/1
  # GET /cancelamentos/1.json
  def show
    @cancelamento = Cancelamento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cancelamento }
    end
  end

  # GET /cancelamentos/new
  # GET /cancelamentos/new.json
  def new
    @cancelamento = Cancelamento.new
    @usuario_id=current_usuario.id
    @periodo=Periodo.find(:last)
$disciplinas_aux = Matricula.find(:all,:conditions=>{:periodo_id=>@periodo.id,:aluno_id=>current_usuario.id,:cancelou=> nil})
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cancelamento }
    end
     
  end

  # GET /cancelamentos/1/edit
  def edit
    @cancelamento = Cancelamento.find(params[:id])
   
    @stat=Matricula.find(:first,:conditions=>{:aluno_id=>@cancelamento.aluno_id})
    @stat.update_attributes(:status=>'10',:parecer=>"Matricula Cancelada")
   
  end

  # POST /cancelamentos
  # POST /cancelamentos.json
  def create
    @cancelamento = Cancelamento.new(params[:cancelamento])
    @periodo=Periodo.find(:last)
    @auxi = Disciplina.find(:all, :conditions => {:nome=> @cancelamento.nomedis,:periodo_id=>@periodo.id})
    @auxi.each do |teste|
      $matricula = Matricula.find(:first,:conditions=> {:disciplina_id=>teste.id})
    if $matricula == nil
      puts 'TESTE'
    else 
      $id=$matricula.disciplina_id
    end
    end
    @cancelamento.disciplina_id = $id
   
    @aluno= Usuario.find(:first, :conditions=> {:id=>current_usuario.id})
    @cancelamento.aluno_id = @aluno.id
    if (@cancelamento.nomedis).include?("mat") 
      @cancelamento.update_attributes(:centro=>'CMCC')
    else
      @cancelamento.update_attributes(:centro=>'CCNH')
    end

    @duplicada= Matricula.find(:first,:conditions=> {:disciplina_id=>$id, :aluno_id=>current_usuario.id})
    @duplicada.update_attributes(:cancelou=> 'Solicitou')
    
    respond_to do |format|
      if @cancelamento.save
        format.html { redirect_to @cancelamento, notice: 'Solicitacao criada com sucesso'}
        format.json { render json: @cancelamento, status: :created, location: @cancelamento }
      else
        format.html { render action: "new" }
        format.json { render json: @cancelamento.errors, status: :unprocessable_entity }
      end
    end
    
    CancelamentoMailer.confirma(@aluno,@parecer,@email,@cancelamento).deliver 
        flash[:notice] = t(:confirma)
        
        if current_usuario.centro=="CMCC"
    CancelamentoMailer.aviso(@aluno,@parecer,@email,@cancelamento).deliver 
        flash[:notice] = t(:confirma)
        else
    CancelamentoMailer.aviso1(@aluno,@parecer,@email,@cancelamento).deliver 
        flash[:notice] = t(:confirma)
  end
  
@testando=@cancelamento.aluno_id
    @usuario=Usuario.find(:first, :conditions => {:id=> @testando})
    @parecer = Cancelamento.find(@cancelamento.id)
    @mensagem = Cancelamento.find(@cancelamento.id)
    @disciplina = Cancelamento.find(@cancelamento.id)
    @cancelamento=Cancelamento.find(@cancelamento.id)
    if @cancelamento.parecer == 'Deferido'
    @stat=Matricula.find(:first,:conditions=>{:aluno_id=>@usuario.id})
    @stat.update_attributes(:status=>'10',:parecer=>"Matricula Cancelada")
    end

  end

  # PUT /cancelamentos/1
  # PUT /cancelamentos/1.json
  
  def update
   
    
@cancelamento =Cancelamento.find(params[:id])
  @parecer = Cancelamento.find(:first,:conditions=> {:id=>@cancelamento.id})
    if @parecer.parecer == 'Deferido'
    @stat=Matricula.find(:last,:conditions=>{:aluno_id=>@usuario.id})
    @stat.update_attributes(:status=>'10',:parecer=>"Matricula Cancelada")
    end
    
    respond_to do |format|
      if @cancelamento.update_attributes(params[:cancelamento])
        format.html { redirect_to @cancelamento, notice: 'Avaliacao realizada com sucesso com sucesso'}
        format.json { head :no_content }
      else
        format.html { render action: "editar" }
        format.json { render json: @cancelamento.errors, status: :unprocessable_entity }
      end
    end
    @cancelamento =Cancelamento.find(params[:id])
    @testando=@cancelamento.aluno_id
    @usuario=Usuario.find(:first, :conditions => {:id=> @testando})
    @parecer = Cancelamento.find(:first,:conditions=> {:id=>@cancelamento.id})
    @mensagem = Cancelamento.find(params[:id])
    @disciplina = Cancelamento.find(params[:id])
    @cancelamento=Cancelamento.find(params[:id])
 CancelamentoMailer.resultado(@usuario,@parecer,@disciplina,@mensagem,@nome).deliver 
        flash[:notice] = t(:resultado)
  
  end
  

  # DELETE /cancelamentos/1
  # DELETE /cancelamentos/1.json
  def destroy
    @cancelamento = Cancelamento.find(params[:id])
    @cancelamento.destroy

    respond_to do |format|
      format.html { redirect_to cancelamentos_url }
      format.json { head :no_content }
    end
  end

end
