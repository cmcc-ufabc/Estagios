module PeriodosHelper
  
  
  
  def retorna_periodo_reajuste(periodo)
    @periodo = periodo
    @retornar = nil
    unless @periodo.blank?
      @inicio = I18n.l periodo.reajuste_inicio
      @fim = I18n.l periodo.reajuste_fim
      @retornar = @inicio.to_s+" ate "+@fim.to_s
    end
    @retornar
  end
  
  def retorna_periodo_edicao(periodo)
    @periodo = periodo
    @retornar = nil
    unless @periodo.blank?
      @inicio = I18n.l periodo.cadastro_inicio
      @fim = I18n.l periodo.cadastro_fim
      @retornar = @inicio.to_s+" ate "+@fim.to_s
    end
    @retornar
  end
  
  def retorna_periodo_matricula(periodo)
    @periodo = periodo
    @retornar = nil
    unless @periodo.blank?
      @inicio = I18n.l periodo.matricula_inicio
      @fim = I18n.l periodo.matricula_fim
      @retornar = @inicio.to_s+" ate "+@fim.to_s
    end
    @retornar
  end
end
