pdf = Prawn::Document.new(:page_size => "A4", :page_layout => :portrait,:margin => [20, 30])
pdf.font "Times-Roman"
pdf.font_size 10
pdf.image "E:/RailsProjects/Estagio/logo.png", :at => [10, 800],:width => 90, :height => 80
@periodo=Periodo.find(params[:id])
@centro=(params[:centro])

pdf.move_down 60
pdf.font ("Helvetica") do
pdf.draw_text "Relatórios Unificado de Matriculas - " + @periodo.quadrimestre + " de " +@periodo.ano.to_s , :at=>[110,760],:size => 14,:style=>:bold,:color => '0F5B3D'
pdf.draw_text "Centro de Matemática, Computação e Cognição ", :at=>[160,740],:size => 12,:style=>:bold,:color => '0F5B3D'
end
 
pdf.font "Helvetica"
pdf.font_size 10
 
pdf.move_down(20)
pdf.font ("Helvetica") do
if @centro == "CMCC"
@centro2="Licenciatura em matemática"
else 
@centro2=["Licenciatura em física","Licenciatura em química","Licenciatura em ciências biológicas","Licenciatura em filosofia"]
end
@disciplina=Disciplina.find(:all,:conditions=>{:periodo_id=>(params[:id]),:curso=>@centro2})


@disciplina.each do |disciplina|
@teste = Array(disciplina.id)



@matricula=Matricula.find(:all,:conditions=>{:disciplina_id=>@teste})
@matricula2=@matricula.uniq!{|d| d.disciplina_id}

@matricula.each do |matricula|
@teste2 = Array(matricula.disciplina_id)

pdf.move_down(20)
@teste2.each do |teste|
pdf.text retorna_materia(teste) + ' - ' + retorna_turno(teste), :style => :bold, :align => :center, :size => 16,:color => "014D31"
pdf.move_down(20)
titulo = [["<b>Aluno</b>", "<b>RA</b>", "<b>Email</b>", "<b>Telefone</b>","<b>Parecer</b>","<b>Docente</b>"]]
cor = "346842"
pdf.table titulo, :column_widths => [110,60,100,80,70,110], :row_colors => [cor,cor], :cell_style => { :text_color => "FFFFFF", :inline_format => true } do
end
i=0
@mat=Matricula.find(:all,:conditions=>{:periodo_id=>(params[:id]),:disciplina_id=>teste})
@mat.each do |mates|
if i%2 == 0
        cor = "F0F0F0"
    else
        cor = "FFFFFF"
    end
 

   
    aux = [[retorna_aluno(mates.id),retorna_ra(mates.aluno_id),retorna_email(mates.id),retorna_telefone(mates.id),retorna_parecer(mates.id),retorna_docente(mates.id)]]
    
    pdf.table aux, :column_widths => [110,60,100,80,70,110], :row_colors => [cor, cor] do
    
    end

    i+=1
    
end
end
end
end
end