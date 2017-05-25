class Formulario < ActiveRecord::Base
  attr_accessible :resposta_2, :resposta_3, :resposta_4, :resposta_5, :aluno_id,
    :periodo_id, :centro, :porcentagem, :mensagem, :resposta_6
  
  validates :resposta_2, :resposta_3, :resposta_4, :resposta_5, :resposta_6, :presence => true
end
