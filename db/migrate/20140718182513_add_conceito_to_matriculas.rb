class AddConceitoToMatriculas < ActiveRecord::Migration
  def change
    add_column :matriculas, :conceito, :string
    add_column :matriculas, :horas, :integer
  end
end
