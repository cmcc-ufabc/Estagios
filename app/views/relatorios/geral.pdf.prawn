pdf = Prawn::Document.new(:page_size => "A4", :page_layout => :portrait,:margin => [20, 30])
pdf.font "Times-Roman"
pdf.font_size 10
pdf.image "C:/Users/erossi/Pictures/logo.png", :at => [10, 800],:width => 90, :height => 80

pdf.move_down 60
pdf.font ("Helvetica") do
pdf.draw_text "Relatórios Unificado de Matriculas - 1º Quadrimestre de 2015", :at=>[110,760],:size => 14,:style=>:bold,:color => '0F5B3D'
pdf.draw_text "Centro de Matemática, Computação e Cognição ", :at=>[160,740],:size => 12,:style=>:bold,:color => '0F5B3D'
end
 
pdf.font "Helvetica"
pdf.font_size 10
 
pdf.move_down(20)
pdf.font ("Helvetica") do
@matricula=Matricula.find(:all,:conditions=>{:periodo_id=>"24"})
@matricula2=@matricula.uniq!{|d| d.disciplina_id}



@matricula2.each do |matricula|
@teste = Array(matricula.disciplina_id)

pdf.move_down(30)



i=0
@teste.each do |mate|
pdf.text retorna_materia(mate) + ' - ' + retorna_turno(mate), :style => :bold, :align => :center, :size => 16,:color => "014D31"
pdf.move_down 10
titulo = [["<b>Aluno</b>", "<b>RA</b>", "<b>Email</b>", "<b>Telefone</b>","<b>Parecer</b>"]]
cor = "346842"
pdf.table titulo, :column_widths => [130,60,160,70,100], :row_colors => [cor,cor], :cell_style => { :text_color => "FFFFFF", :inline_format => true } do
end

i=0
@mat=Matricula.find(:all,:conditions=>{:periodo_id=>24,:disciplina_id=>mate})
@mat.each do |mates|
if i%2 == 0
        cor = "F0F0F0"
    else
        cor = "FFFFFF"
    end
 

   
    aux = [[retorna_aluno(mates.id),retorna_ra(mates.id),retorna_email(mates.id),retorna_telefone(mates.id),retorna_parecer(mates.id)]]
    
    pdf.table aux, :column_widths => [130,60,160,70,100], :row_colors => [cor, cor] do
    
    end

    i+=1
    
end
end
end
end
