class UsersController < ApplicationController
  
  
  before_filter :authenticate_usuario!#, :except=>[:show]
  
  def show
    unless possui_acesso?()
      return
    end
    @aluno = Usuario.find(params[:id])
    @cursos = Curso.find(:all, :conditions => {:aluno_id => params[:id]})
  end
  
  def index
    unless possui_acesso?()
      return
    end
    @usuarios = Usuario.find(:all, :order => 'nome')
  end

  def edit
    unless possui_acesso?()
      return
    end
    @usuario = Usuario.find(params[:id])
  end
  
  def update
    unless possui_acesso?()
      return
    end

    @parametros = params[:usuario]
    @usuario = Usuario.find(params[:id])

      if @usuario.update_attributes(params[:usuario])
            flash[:notice] = t(:editado_com_sucesso) 
            redirect_to ('/estagios/users/')

      else
        flash[:notice] = t(:erro_ao_editar)
        respond_to do |format|
            format.html { render action: "edit" }
            format.json { render json: @usuario.errors, status: :unprocessable_entity }             
        end
      end    
    
    
  end
end
