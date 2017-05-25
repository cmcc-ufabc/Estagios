#pdf = Prawn::Document.new(:page_size => "A4", :page_layout => :landscape,:background  => "E:/RailsProjects/Estagio/logo2.png")
pdf.font "Helvetica"
pdf.font_size 9

pdf.image  "E:/RailsProjects/Estagio/logo2.png", :height => 100



pdf.move_down(20)
@quadrimestre = Periodo.find(:first,:conditions=>{:id=>params[:id]})
pdf.text @quadrimestre.quadrimestre + ' de ' + @quadrimestre.ano.to_s, :align => :center,:size=> 14
pdf.move_down(20)


titulo = [["<b>Aluno</b>", "<b>RA</b>", "<b>Disciplina</b>", "<b>Código</b>","<b>Conceito</b>"]]
cor = "346842"
pdf.table titulo, :column_widths => [180,50,210,50,50,50], :row_colors => [cor,cor], :cell_style => { :text_color => "FFFFFF", :inline_format => true } do
end

    i = 0

@pesquisa = Matricula.find(:all,:conditions=>{:periodo_id=>params[:id],:conceito=>"Aprovado",:numero_ci=>params[:ci],:centro=>current_usuario.centro})
@pesquisa.each do |linha|
    disciplina = Disciplina.find(linha.disciplina_id)

   

            if i%2 == 0
                cor = "FEE378"
            else
                cor = "FFFFFF"
            end
 

            @aluno = Usuario.find(linha.aluno_id)            
            @nome_disciplina = retorna_nome_disciplina(linha.disciplina_id)
            @codigo = retorna_codigo(linha.disciplina_id)
            aux = [[@aluno.nome,@aluno.ra,@nome_disciplina,@codigo,linha.conceito]]
    
            pdf.table aux, :column_widths => [180,50,210,50,50,50], :row_colors => [cor, cor] do
    
            end

            i+=1

    
    
end

pdf.move_down(20)
pdf.font ("Helvetica") do
if 
pdf.text "Relatório enviado ao DSSI no dia "+@data.to_s, :align => :center
end
pdf.move_down(10)
pdf.text "Este relatório está registrado sobre o número de CI: " + params[:ci].to_s, :align => :center
end
