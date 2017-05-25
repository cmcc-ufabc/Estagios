if  1==1
#pdf = Prawn::Document.new(:page_size => "A4", :page_layout => :landscape,:template => "C:/Users/erossi/Documents/Programas 2015/Estagio/Template Relatorio.pdf)
pdf.font "Times-Roman"
pdf.font_size 9


pdf.font ("Helvetica") do
pdf.text "Relatório de matrículas - "+@periodo.quadrimestre.to_s+" de "+@periodo.ano.to_s, :style => :bold, :align => :center, :size => 16
pdf.move_down(15)
pdf.text @disciplinas[0].nome, :style => :bold, :align => :center, :size => 18,:color => "014D31"
pdf.move_down(30)
end
pdf.font ("Helvetica")


titulo = [["<b>Código</b>", "<b>Disciplina</b>", "<b>Turno</b>", "<b>Inicio</b>","<b>Fim</b>"]]
cor = "346842"
pdf.table titulo, :column_widths => [70,210,70,80,80], :row_colors => [cor,cor], :cell_style => { :text_color => "FFFFFF", :inline_format => true } do
end

    i = 0

@disciplinas.each do |disciplinas|

    if i%2 == 0
        cor = "F0F0F0"
    else
        cor = "FFFFFF"
    end
 
    
    
    @disciplinas = Disciplina.find(disciplinas.id)
    aux = [[@disciplinas.codigo,@disciplinas.nome,@disciplinas.turno,@disciplinas.horario_inicio.strftime("%H:%M:%S").to_s,@disciplinas.horario_fim.strftime("%H:%M:%S").to_s]]
   
    pdf.table aux, :column_widths => [70,210,70,80,80], :row_colors => [cor, cor] do
    
    end

    i+=1
    
end



pdf.move_down(30)
pdf.text "Diurno", :style => :bold, :align => :center, :size => 16,:color => "014D31"
pdf.move_down(10)
titulo = [["<b>Aluno</b>", "<b>RA</b>", "<b>Email</b>", "<b>Telefone</b>","<b>Parecer</b>"]]
cor = "346842"
pdf.table titulo, :column_widths => [130,50,160,70,100], :row_colors => [cor,cor], :cell_style => { :text_color => "FFFFFF", :inline_format => true } do
end

    i = 0
@matriculas.each do |linha|

    if i%2 == 0
        cor = "F0F0F0"
    else
        cor = "FFFFFF"
    end
 
    
    @aluno = Usuario.find(linha.aluno_id)
    @disciplinas = Disciplina.find(linha.disciplina_id)
    if @disciplinas.turno == "Diurno"
    aux = [[@aluno.nome,@aluno.ra,@aluno.email,@aluno.telefone,linha.parecer,]]
   
    pdf.table aux, :column_widths => [130,50,160,70,100], :row_colors => [cor, cor] do
    
    end

    i+=1
    
end

end
end

pdf.move_down(30)
pdf.text "Noturno", :style => :bold, :align => :center, :size => 16,:color => "014D31"
pdf.move_down(10)
titulo = [["<b>Aluno</b>", "<b>RA</b>", "<b>Email</b>", "<b>Telefone</b>","<b>Parecer</b>"]]
cor = "346842"
pdf.table titulo, :column_widths => [130,50,160,70,100], :row_colors => [cor,cor], :cell_style => { :text_color => "FFFFFF", :inline_format => true } do
end

    i = 0
@matriculas.each do |linha|

    if i%2 == 0
        cor = "F0F0F0"
    else
        cor = "FFFFFF"
    end
 
    
    @aluno = Usuario.find(linha.aluno_id)
    @disciplinas = Disciplina.find(linha.disciplina_id)
    if @disciplinas.turno == "Noturno"
    aux = [[@aluno.nome,@aluno.ra,@aluno.email,@aluno.telefone,linha.parecer,]]
   
    pdf.table aux, :column_widths => [130,50,160,70,100], :row_colors => [cor, cor] do
    
    end

    i+=1
    
end

end

if @matri != 0 

pdf.move_down(30)
pdf.font ("Helvetica") do
pdf.text "Relatório de cancelamentos", :style => :bold, :align => :center, :size => 16

pdf.move_down(30)




titulo = [["<b>Aluno</b>", "<b>RA</b>", "<b>Email</b>", "<b>Telefone</b>","<b>Parecer</b>"]]
cor = "346842"
pdf.table titulo, :column_widths => [130,50,160,70,100], :row_colors => [cor,cor], :cell_style => { :text_color => "FFFFFF", :inline_format => true } do
end

    i = 0
@matri.each do |linha|

    if i%2 == 0
        cor = "F0F0F0"
    else
        cor = "FFFFFF"
    end
 
    
    @aluno = Usuario.find(linha.aluno_id)
    @disciplinas = Disciplina.find(linha.disciplina_id)
    aux = [[@aluno.nome,@aluno.ra,@aluno.email,@aluno.telefone,linha.parecer,]]
   
    pdf.table aux, :column_widths => [130,50,160,70,100], :row_colors => [cor, cor] do
    
    end

    i+=1
    
end

end


pdf.move_down(10)
pdf.font ("Helvetica") do
pdf.text "Relatório gerado dia "+@agora.strftime("%d/%m/%Y - %H:%M:%S").to_s, :align => :center
end
end