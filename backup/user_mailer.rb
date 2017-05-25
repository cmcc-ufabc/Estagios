class UserMailer < ActionMailer::Base
  default :from => 'estagios.licenciaturaufabc@gmail.com'
  
  include ApplicationHelper
  include MatriculasHelper
  
  def disciplina_editada(matricula)
    @disciplina = Disciplina.find(matricula.disciplina_id)
    @aluno = Usuario.find(matricula.aluno_id)
    
    mail(:to => @aluno.email, :subject => t(:disciplina_editada))
  end
  
  def modelo_ci(curso,periodo,remetente)
    @remetente = remetente
    @periodo = periodo
    @curso = curso 
    @agora = I18n.l Date.today, :format => :long
    
    @link = 'http://cmcc-bcc.ufabc.edu.br/estagios/conceitos/dssi/'+@periodo.id.to_s+'/'+@periodo.registrador_ci.to_s

    mail(:to => "dssi.prograd@ufabc.edu.br", :subject => t(:lancamento_conceito))
  end
  
  def relatorio_matriculas(email,disciplina,remetente)    
    @remetente = remetente
    @email = email
    @disciplina = disciplina
    @periodo = Periodo.find(@disciplina.periodo_id)

    case @disciplina.curso
      when t(:lic_ciencia_bio)
        @curso = "bio"
        
      when t(:lic_filosofia)
        @curso = "filo"
        
      when t(:lic_fisica)
        @curso = "fis"
        
      when t(:lic_matematica)
        @curso = "mat"
        
      when t(:lic_quimica)
        @curso = "qui"      
    end    
    
    
    @link = 'http://cmcc-bcc.ufabc.edu.br/estagios/relatorios/view/'+@periodo.id.to_s+'/'+@curso+'/'+@disciplina.codigo.to_s

    
    mail(:to => @email, :subject => "Analises de matricula")
  end
  
  def analise_matricula(matricula)    
    @matricula = matricula
    @aluno = Usuario.find(@matricula.aluno_id)
    @disciplina = Disciplina.find(@matricula.disciplina_id)
    mail(:to => @aluno.email, :subject => "Analise da matricula")
  end
  
  def matriculas(usuario,matriculas)
    @hoje = I18n.l Time.now
    @usuario = usuario
    @matriculas = matriculas
    

    @disciplinas = [["Codigo","Nome","Turno","Dia","Horario"]]
    
    @matriculas.each do|matricula|
      disciplina_aux = Disciplina.find(matricula.disciplina_id)
      horario_inicio = I18n.l disciplina_aux.horario_inicio, :format => :hora
      horario_fim = I18n.l disciplina_aux.horario_fim, :format => :hora
      horario = "das "+horario_inicio.to_s+" as "+horario_fim.to_s
      @aux = [[disciplina_aux.codigo],[disciplina_aux.nome],[disciplina_aux.turno],[disciplina_aux.dia],[horario]]
      @disciplinas.append(@aux)
    end
    mail(:to => @usuario.email, :subject => "Matriculas em disciplina") 
    
  end
end
