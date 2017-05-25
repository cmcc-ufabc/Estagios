class Periodo < ActiveRecord::Base
  attr_accessible :matricula_fim, :matricula_inicio, :reajuste_fim, :reajuste_inicio,
    :quadrimestre, :ano, :cadastro_inicio, :cadastro_fim, :registrador_ci, :remanescente_inicio,  :remanescente_fim
  
  validate :matricula_inicio_menor_matricula_fim?, :reajuste_inicio_menor_reajuste_fim?
  validate :matricula_fim_menor_reajuste_inicio?
  validates :ano, :presence => true, :numericality => true
  validates_size_of :ano, :is => 4
  
  def cadastro_fim_menor_matricula_inicio?
    if cadastro_fim > matricula_inicio
      errors.add(:matricula_inicio, :cadastro_matricula)
    end
  end    
  
  def matricula_fim_menor_reajuste_inicio?
    if matricula_fim > reajuste_inicio
      errors.add(:reajuste_inicio, :matricula_reajuste)
    end
  end  
  
  def matricula_inicio_menor_matricula_fim?
    if matricula_inicio > matricula_fim
      errors.add(:matricula_inicio, :periodo_matricula_invalido)
    end
  end 
  
  def reajuste_inicio_menor_reajuste_fim?
    if reajuste_inicio > reajuste_fim
      errors.add(:reajuste_inicio, :periodo_reajuste_invalido)
    end
  end 

  def cadastro_inicio_menor_cadastro_fim?
    if cadastro_inicio > cadastro_fim
      errors.add(:cadastro_inicio, :periodo_cadastro_invalido)
    end
  end 
  
end
