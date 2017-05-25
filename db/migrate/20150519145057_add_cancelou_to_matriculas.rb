class AddCancelouToMatriculas < ActiveRecord::Migration
  def change
    add_column :matriculas, :cancelou, :string
  end
end
