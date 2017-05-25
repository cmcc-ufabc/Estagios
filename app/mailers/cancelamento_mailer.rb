class CancelamentoMailer < ActionMailer::Base
  default from: "estagios.licenciaturaufabc@gmail.com"
  
  include ApplicationHelper
  include MatriculasHelper
  include CancelamentosHelper
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.cancelamento_mailer.cancelamentos.subject
  #
  def cancelamentos
    @greeting = "Hi"

    mail to: ""
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.cancelamento_mailer.user_mailer.subject
  #
  def user_mailer
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.cancelamento_mailer.user.subject
  #
  def resultado (usuario,parecer,disciplina,mensagem,nome)
  
    @usuario=usuario
  @cancelamento=nome
    @cancelamento= mensagem
    @parecer = parecer
    @cancelamento=disciplina
    @hoje = I18n.l Time.now
    
    mail(:to => @usuario.email, :subject => "Cancelamento de Matricula")
  end
  

def confirma(aluno,parecer,email,disciplina)
    @email = email
    @aluno = aluno
    @parecer = parecer
    @cancelamento=disciplina
    @hoje = I18n.l Time.now
    
    mail(:to => @aluno.email, :subject => "Cancelamento de Matricula")
  end
  
  def aviso(aluno,parecer,email,disciplina)
    @email = email
    @aluno = aluno
    @parecer = parecer
    @cancelamento=disciplina
    @hoje = I18n.l Time.now
    
    mail(:to => 'secretariacmcc@ufabc.edu.br', :subject => "Aviso de Novo Pedido")
  end
  def aviso1(aluno,parecer,email,disciplina)
    @email = email
    @aluno = aluno
    @parecer = parecer
    @cancelamento=disciplina
    @hoje = I18n.l Time.now
    
    mail(:to => 'secretariaccnh@ufabc.edu.br', :subject => "Aviso de Novo Pedido")
  end
  
end