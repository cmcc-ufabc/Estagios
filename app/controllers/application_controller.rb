class ApplicationController < ActionController::Base
  
  protect_from_forgery
  before_filter :authenticate_usuario!#, :except=>[:show]

    def retorna_periodo_dssi(periodo)
      #gera o modelo de período para a planinha em Excel no formato [ano].[quadrimestre]
      @retornar = "desconhecido"
    if periodo.quadrimestre == t(:q1)
      @retornar = periodo.ano.to_s+"."+1.to_s
    elsif periodo.quadrimestre == t(:q2)
      @retornar = periodo.ano.to_s+"."+2.to_s
    elsif periodo.quadrimestre == t(:q3)
      @retornar = periodo.ano.to_s+"."+3.to_s
    end
    
    @retornar
  end
  
  
  def possui_acesso?()
    #verifica se o usuário possuí acesso à determinado conteúdo.
    
    if usuario_signed_in?
        #para o caso do usuário não estar logado
        unless current_usuario.tipo == "Administrador" or current_usuario.tipo == "Secretaria"
            render "avisos/entrada_incorreta"
            return false
        else
            return true
        end
    else
        #Usuario não logado ou desconectado devido ociosidade
        render "avisos/nao_logado"
        return false
    end

    
  end

  def retorna_nome_aluno(id_do_aluno)
    @aluno = Usuario.find(id_do_aluno).nome
  end
  
  def retorna_ra(id_do_aluno)
    @aluno = Usuario.find(id_do_aluno).ra
  end    
  
  def retorna_nome_disciplina(id_da_disciplina)
    @disciplina = Disciplina.find(id_da_disciplina).nome
  end
  
  def retorna_codigo(id_da_disciplina)
    @disciplina = Disciplina.find(id_da_disciplina).codigo
  end
  
    def periodo_atual()
        @periodos = Periodo.find(:all, :conditions => ['cadastro_inicio <= ? AND reajuste_fim >= ?', Date.today, Date.today])
        @periodo = @periodos[0]
        @periodo
    end

  
end
