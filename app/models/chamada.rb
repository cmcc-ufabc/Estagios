class Chamada < ActiveRecord::Base
  attr_accessible :aluno_id, :mensagem_aluno, :mensagem_sec, :tipo_chamada,:protocolo,:status,:periodo_id
  validates :mensagem_aluno, :presence => true
  validates :tipo_chamada, :presence => true
end
