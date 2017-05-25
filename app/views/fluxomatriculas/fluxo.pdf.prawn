#pdf = Prawn::Document.new(:page_size => "A4", :page_layout => :landscape,:background  => "C:/Users/erossi/Pictures/logo.png")
pdf.font "Helvetica"
pdf.font_size 11

pdf.image  "E:/RailsProjects/Estagio/logo4.png", :height => 50, :at => [90, 740]
pdf.move_down(50)
pdf.text  "RELATÓRIO DE FLUXO DE MATRICULA DO SISTEMA",:align => :center, :size=> 14

@pesquisa = Usuario.find(:first,:conditions=>{:id=>params[:aluno_id]})
pdf.move_down(20)
pdf.text  'Nome: ' + @pesquisa.nome
pdf.move_down(5)
pdf.text 'RA: ' +@pesquisa.ra


pdf.move_down(20)



titulo = [["<b>Disciplina</b>", "<b>Quadrimestre</b>", "<b>Ano</b>", "<b>Data</b>"]]
cor = "346842"
pdf.table titulo, :column_widths => [280,100,50,80], :row_colors => [cor,cor], :cell_style => { :text_color => "FFFFFF", :inline_format => true } do
end

 i = 0

@pesquisa = Fluxomatricula.find(:all,:conditions=>{:aluno_id=>params[:aluno_id],:periodo_id=>params[:periodo_id]})
@pesquisa.each do |linha|
    disciplina = Disciplina.find(linha.disciplina_id)

   

            if i%2 == 0
                cor = "FEE378"
            else
                cor = "FFFFFF"
            end
 

                       
            @nome_disciplina = disciplina.nome
            @quadrimestre = retorna_quadrimestre(disciplina.periodo_id)
            @ano= retorna_ano(disciplina.periodo_id)

            @codigo = retorna_codigo(linha.disciplina_id)
            aux = [[@nome_disciplina,@quadrimestre,@ano,linha.data]]
    
            pdf.table aux, :column_widths => [280,100,50,80], :row_colors => [cor, cor] do
    
            end

            i+=1

    
    
end

pdf.move_down(20)
pdf.font ("Helvetica") do

end