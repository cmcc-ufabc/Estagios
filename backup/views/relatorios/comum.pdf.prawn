
#pdf = Prawn::Document.new(:page_size => "A4", :page_layout => :landscape)
pdf.font "Times-Roman"
pdf.font_size 9

pdf.font ("Helvetica") do
pdf.text "Relatório de matrículas - "+@periodo.quadrimestre.to_s+" de "+@periodo.ano.to_s, :style => :bold, :align => :center, :size => 16
pdf.text @disciplinas[0].nome, :style => :bold, :align => :center, :size => 14, :color => '3399FF'
end

pdf.move_down(30)

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
    aux = [[@aluno.nome,@aluno.ra,@aluno.email,@aluno.telefone,linha.parecer]]
    
    pdf.table aux, :column_widths => [130,50,160,70,100], :row_colors => [cor, cor] do
    
    end

    i+=1
    
end

pdf.move_down(10)
pdf.font ("Helvetica") do
pdf.text "Relatório gerado dia "+@agora.strftime("%d/%m/%Y - %H:%M:%S").to_s, :align => :center
end