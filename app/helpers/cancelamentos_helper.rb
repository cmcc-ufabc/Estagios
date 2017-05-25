module CancelamentosHelper
  def parecer
   if @cancelamento.parecer == 'Deferido'
      @cancelamento.status = 10
    end
  end
  def retorna_nome_dis(id)
    @dis=Disciplina.find(:first,:conditions=>{:id=>id})
    @dis.nome
  end
   
end
