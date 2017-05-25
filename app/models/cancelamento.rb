class Cancelamento < ActiveRecord::Base
  belongs_to :matricula
  attr_accessible :aluno_id, :disciplina_id, :justificativa, :nomedis, :parecer, :status, :mensagem,:periodo_id,:centro
 validates :justificativa, :presence => true
 
end
