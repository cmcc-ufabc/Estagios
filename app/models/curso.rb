class Curso < ActiveRecord::Base
  attr_accessible :aluno_id, :nome_do_curso
  
  validate :entrada_dupla
  
  def entrada_dupla
    @curso = Curso.find(:first, :conditions => {:aluno_id => aluno_id, :nome_do_curso => nome_do_curso})
    if @curso == nil
      return true
    else
      
      errors.add(:duplicado, "ja cadastrado")
      return false
    end
  end
end
