
#pdf = Prawn::Document.new(:page_size => "A4", :page_layout => :landscape)
pdf.font "Times-Roman"
pdf.font_size 9

pdf.font ("Helvetica") do
pdf.text "Relatório de conceitos - "+@periodo.quadrimestre.to_s+" de "+@periodo.ano.to_s, :style => :bold, :align => :center, :size => 16
pdf.text @curso, :style => :bold, :align => :center, :size => 14, :color => '3399FF'
end

pdf.move_down(30)

titulo = [["<b>Aluno</b>", "<b>RA</b>", "<b>Disciplina</b>", "<b>Código</b>","<b>Conceito</b>"]]
cor = "346842"
pdf.table titulo, :column_widths => [180,50,180,50,50,50], :row_colors => [cor,cor], :cell_style => { :text_color => "FFFFFF", :inline_format => true } do
end

    i = 0
@matriculas.each do |linha|
    disciplina = Disciplina.find(linha.disciplina_id)

    if disciplina.curso == @curso

            if i%2 == 0
                cor = "F0F0F0"
            else
                cor = "FFFFFF"
            end
 

            @aluno = Usuario.find(linha.aluno_id)            
            @nome_disciplina = retorna_nome_disciplina(linha.disciplina_id)
            @codigo = retorna_codigo(linha.disciplina_id)
            aux = [[@aluno.nome,@aluno.ra,@nome_disciplina,@codigo,linha.conceito]]
    
            pdf.table aux, :column_widths => [180,50,180,50,50,50], :row_colors => [cor, cor] do
    
            end

            i+=1

    end
    
end

pdf.move_down(10)
pdf.font ("Helvetica") do
pdf.text "Relatório gerado dia "+@agora.strftime("%d/%m/%Y - %H:%M:%S").to_s, :align => :center
end