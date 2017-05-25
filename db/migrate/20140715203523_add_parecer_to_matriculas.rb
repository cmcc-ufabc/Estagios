class AddParecerToMatriculas < ActiveRecord::Migration
  def change
    add_column :matriculas, :parecer, :string
  end
end
