module ApplicationHelper
  
  def periodo_editar_disciplina()
        @periodos = Periodo.find(:all, :conditions => ['cadastro_inicio <= ? AND cadastro_fim >= ?', Date.today, Date.today])
        @periodo = @periodos[0]
        
        if @periodo.blank?
          return false
        else
          return true
        end
  end
  
  def periodo_de_cadastro_de_disciplina()
        @periodos = Periodo.find(:all, :conditions => ['cadastro_inicio <= ? AND cadastro_fim >= ?', Date.today, Date.today])
        @periodo = @periodos[0]
        periodo
  end      
  
    def periodo_de_matricula()
        @matriculas = Periodo.find(:all, :conditions => ['matricula_inicio <= ? AND matricula_fim >= ?', Date.today, Date.today])
        @matricula = @matriculas[0]
        
        @reajustes = Periodo.find(:all, :conditions => ['reajuste_inicio <= ? AND reajuste_fim >= ?', Date.today, Date.today])
        @reajuste = @reajustes[0]
        
        if @matricula.blank? and @reajuste.blank?
          return false
        else
          return true
        end
    end
  
    def periodo_atual()
        @periodos = Periodo.find(:all, :conditions => ['matricula_inicio <= ? AND reajuste_fim >= ?', Date.today, Date.today])
        @periodo = @periodos[0]
        @periodo
    end
  
end
