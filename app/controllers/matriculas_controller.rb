class MatriculasController < ApplicationController
  # GET /matriculas
  # GET /matriculas.json
  before_filter :authenticate_usuario!#, :except=>[:download]

  def detalhes
    unless possui_acesso?()
      return
    end
    @formulario = Formulario.new
    @aluno = Usuario.find(params[:id])
    @cursos = Curso.find(:all, :conditions => {:aluno_id => params[:id]})
    @matriculas = Matricula.find(:all, :conditions => {:aluno_id => params[:id], :status => 0})
    #status > 0 indica que ele foi aprovado em quadrimestres anteriores (-1 quando reprovado)
    @historico = Matricula.find(:all, :conditions => ['status > ? AND aluno_id = ?',0,@aluno.id])
    @historico.reverse!
    
  end
  
  def filtro
    unless possui_acesso?()
      return
    end
    @filtro = params[:filtro].to_a    
    $curso = @filtro[0][1]
        

    redirect_to :back
  end
  
  def download
    unless possui_acesso?()
      return
    end
    @matricula = Matricula.find(params[:id])
    send_file  @matricula.arquivo.path
    
  end
  
  def anexo
    
      @matricula = Matricula.find(params[:id])
      if @matricula.update_attributes(params[:informacoes])
          flash[:notice] = t(:anexo_enviado) #arquivo e mensagem enviados com sucesso!
      else
          flash[:erro] = t(:anexo_erro)
      
      end
      
  redirect_to :back
    
  end
  
  def email_matriculas
      @matriculas = Matricula.find(:all, :conditions => {:aluno_id => current_usuario.id, :periodo_id => Periodo.find(:last).id})
      UserMailer.matriculas(Usuario.find(current_usuario.id),@matriculas).deliver
      redirect_to :back
      flash[:notice] = t(:emailenviado)
  end
  
  def cadastro   
    
    @periodo = Periodo.find(:last)    
    
        @matriculas = Periodo.find(:all, :conditions => ['matricula_inicio <= ? AND matricula_fim >= ?', Date.today, Date.today])
        @matricula = @matriculas[0]
        
        @reajustes = Periodo.find(:all, :conditions => ['reajuste_inicio <= ? AND reajuste_fim >= ?', Date.today, Date.today])
        @reajuste = @reajustes[0]
        
        @remanescente = Periodo.find(:all, :conditions => ['remanescente_inicio <= ? AND remanescente_fim >= ?', Date.today, Date.today])
        @remanescente = @remanescente[0]
        
        if @matricula.blank? and @reajuste.blank? and @remanescente.blank?
          flash[:erro] = t(:entrada_incorreta)
          redirect_to :controller => 'avisos', :action => 'index'          
          return
        end      
    
    
    @disciplinas = Disciplina.find(:all, :conditions => {:periodo_id => @periodo.id}, :order => "nome")
  end
  
  def index
    unless possui_acesso?()
      return
    end
    @periodo = Periodo.find(:last)
    
    unless @periodo.blank?
        @matriculas = Matricula.find(:all, :conditions =>{:periodo_id => @periodo.id, :status => 0})
    end  
    #armazena os RAs dos alunos, para que cada um seja mostrado apenas uma vez      
    $alunos = [[nil]]
    
      

    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @matriculas }
    end
  end

      def individual
    unless possui_acesso?()
      return
    end
    @periodo = Periodo.find(:last)
    
    unless @periodo.blank?
          @matriz=Array.new
          @usuarios=Usuario.find(:all,:order=>'nome')
          @usuarios.each do |user|
            @matricula = Matricula.find(:all,:conditions=>{:centro=>current_usuario.centro,:aluno_id=>user.id})
          
          @matricula.each do |matricula|
          @matriz.append(matricula.aluno_id)
		  @novamatriz=@matriz.uniq
        end
          end
    end
        
    
    #armazena os RAs dos alunos, para que cada um seja mostrado apenas uma vez      
    $alunos = [[nil]]
    
      

    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @matriculas }
    end
  end
      

    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @matriculas }
    end
  
  
  # GET /matriculas/1
  # GET /matriculas/1.json
  def show
    unless possui_acesso?()
      return
    end
    @matricula = Matricula.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @matricula }
    end
  end

  # GET /matriculas/new
  # GET /matriculas/new.json
  def new
    unless possui_acesso?()
      return
    end
    @matricula = Matricula.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @matricula }
    end
    
  end

  # GET /matriculas/1/edit
  def edit
    unless possui_acesso?()
      return
    end
    @matricula = Matricula.find(params[:id])
  end

  # POST /matriculas
  # POST /matriculas.json
  
  
  def create     #inicio
    $filtro = nil
    $id_do_usuario = current_usuario.id
    @disciplinas = params[:disciplinas]
    @cursos_antigo = Curso.find(:all, :conditions => {:aluno_id => current_usuario.id})
    @cursos_novo = params[:cursos]
    @periodo = Periodo.find(:last)
    
  
   
    if @cursos_novo.blank?
        #ao menos um curso deve ser informado
        flash[:erro] = t(:erro_curso)
        redirect_to :back
        return
        
    else
      
        @cursos_novo.each do |curso| 
            #salva os cursos informados no banco de dados
            @curso = Curso.new :aluno_id => current_usuario.id, :nome_do_curso => curso
            @curso.save
  
        end

      
    end
    
    @cursos_antigo.each do |curso_antigo|
        #apaga o curso, caso o aluno desmarque o checkbox
        @desistiu = @cursos_novo.detect{|k| k==curso_antigo.nome_do_curso}
      
        if @desistiu.blank?
          #se estiver vazio o curso nao foi encontrado
          curso_antigo.destroy
        end
     
    end
    
    
    
    if @disciplinas.blank?
        #apaga todas as matriculas, para o caso do aluno ter desmarcado
        @matriculas = Matricula.find(:all, :conditions => {:aluno_id => current_usuario.id, :periodo_id => @periodo.id})
        @matriculas.each do |matricula|
          matricula.destroy
        end
        respond_to do |format|
                format.html { redirect_to :root, notice: 'Matriculas realizadas com sucesso.' }
                format.json { render json: @matricula, status: :created, location: @matricula }
        end
        return
      
    end
     
    #verifica se existe alguma matricula fora as que o aluno solicitou agora
    # - para o caso de ter desistido de uma disciplina   
    @matriculas_atuais = Matricula.find(:all, :conditions => {:aluno_id => $id_do_usuario, :periodo_id => @periodo.id})
    @matriculas_atuais.each do |m|
      
            @desistiu = @disciplinas.detect{|j| j.to_i == m.disciplina_id}
            if @desistiu.blank?
              m.destroy
            end
    
    end  
    
    erro_matricula = false
    @disciplinas.each do |disciplina|
      
      #verifica se o aluno ja se matriculou na disciplina
      @aux = Matricula.find(:first, :conditions => {:disciplina_id => disciplina, :periodo_id => @periodo.id, :aluno_id => current_usuario.id})
      if @aux.blank?  
          #aluno nao me matriculou na disciplina
          @disciplina_aux = Disciplina.find(disciplina)
          
          #verifica se o aluno informou o curso que e corresponte a disciplina
          @curso_equivalente = @cursos_novo.detect{|i| i==@disciplina_aux.curso}
          
          unless @curso_equivalente.blank? 
                #verifica o centro do curso informado
          if  @disciplina_aux.curso.include? "Licenciatura em matem"
            @centro = 'CMCC'
          else
            @centro='CCNH'
          end
                #a disciplina informada pertence ao curso do aluno
                @matricula = @disciplina_aux.matriculas.create(:aluno_id => current_usuario.id, :periodo_id => @periodo.id, :status => 0, :parecer => "Aguardando analise da secretaria",:centro=>@centro)    
                unless @matricula.save
                    erro_matricula = true
                    flash[:erro] = t(:erro_matricula) #Uma ou mais disciplinas nao puderam ser salvas devido a conflito de horarios
                    break
                end     
          else
                flash[:erro] = t(:curso_nao_informado)
                erro_matricula = true
          end
       
      end
      
    end  
    


         unless erro_matricula
            respond_to do |format|
                format.html { redirect_to :root, notice: 'Matriculas realizadas com sucesso.' }
                format.json { render json: @matricula, status: :created, location: @matricula }
            end
         else
            #------------------------------------
            #houveram erros na matricula
            redirect_to :back

         end
         @estagioanterior=Matricula.find(:first,:conditions=>{:aluno_id=>current_usuario.id,:parecer=>"Aprovado"})
         if @estagioanterior != nil
           @periodoatual=Periodo.find(:last)
           @automatico=Matricula.find(:all,:conditions=>{:periodo_id=>@periodoatual.id,:aluno_id=>current_usuario.id})
           @disci=[]
           @automatico.each do |auto|
             @disci.append(auto.disciplina_id)
             auto.update_attributes(:status=>1,:parecer=>"Aprovado")
              @periodo=Periodo.find(:last)
              @form=Formulario.create(:resposta_2=> "Sim",:resposta_3=> 'Sim',:resposta_4=> "Sim",:resposta_5=> "Sim",:aluno_id=>current_usuario.id,:periodo_id=>@periodo.id,:centro=>current_usuario.centro,:resposta_6=>'Nao',:centro=>@estagioanterior.centro)
              
           end
           @aluno=current_usuario.nome
           @retorna_email=Usuario.find(:first,:conditions=>{:id=>current_usuario.id})
           @email=@retorna_email.email
           UserMailer.analise_automatica(@aluno,@disci,@email).deliver 
        flash[:notice] = t(:analise_automatica)
         end
          @testando = Fluxomatricula.new :aluno_id=> current_usuario.id, :disciplina_id=>@matricula.disciplina_id, :data=> Time.now, :periodo_id=> @matricula.periodo_id
   @testando.save
  end # fim

  # PUT /matriculas/1
  # PUT /matriculas/1.json
  def relindiv
    @agora=Time.now
  end
  def analise
    unless possui_acesso?()
      return
    end
    
    @periodo = Periodo.find(:last)
    @formulario = Formulario.new(params[:formulario])
    @formulario.aluno_id = params[:id]
    @formulario.periodo_id = @periodo.id
    @formulario.centro = current_usuario.centro
    @aluno = Usuario.find(params[:id])
    @ids = [[nil]]
    unless @formulario.save
        flash[:erro] = t(:erro_formulario_solicitacao) #uma ou mais respostas nao foram preenchidas
        redirect_to :back
        return
      
    end 
    
    if @formulario.resposta_3 == "Sim" and @formulario.resposta_4 == "Sim" and @formulario.resposta_5 == "Sim" and @formulario.resposta_6 == t(:nao)
      @parecer = "Aprovado"
      @status = 1
    else
      @parecer = "Reprovado"
      @status = -1      
    end
    
   
    @matriculas = Matricula.find(:all, :conditions => {:periodo_id => @periodo.id, :aluno_id => params[:id], :status => 0})
    @matriculas.each do |matricula|
        @disciplina = Disciplina.find(matricula.disciplina_id)
        
        if current_usuario.centro == "CMCC"
          @email = "(secretariacmcc@ufabc.edu.br)"
          if @disciplina.curso == t(:lic_matematica)
              matricula.parecer = @parecer
              matricula.status = @status
              @ids.append(matricula.disciplina_id)
              matricula.save
          end          
        
        else
          #o usuario e do centro CCNH, nao troca o status se for
          #licenciatura em matematica
          @email = "(secretariaccnh@ufabc.edu.br)"
          unless @disciplina.curso == t(:lic_matematica)
              matricula.parecer = @parecer
              matricula.status = @status
              @ids.append(matricula.disciplina_id)
              matricula.save
          end
        end
      


    end
        #envia um email para o aluno com o resultado da avaliacao
        UserMailer.analise_matricula(@aluno,@ids,@parecer,@formulario,@email).deliver 
        flash[:notice] = t(:analise_realizada)
        redirect_to matriculas_path
 

  end

  # DELETE /matriculas/1
  # DELETE /matriculas/1.json
  def destroy
    unless possui_acesso?()
      return
    end
    @matricula = Matricula.find(params[:id])
    @matricula.destroy

    respond_to do |format|
      format.html { redirect_to matriculas_url }
      format.json { head :no_content }
    end
  end
  
end
