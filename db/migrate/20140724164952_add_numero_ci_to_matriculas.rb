class AddNumeroCiToMatriculas < ActiveRecord::Migration
  def change
    add_column :matriculas, :numero_ci, :integer
  end
end
