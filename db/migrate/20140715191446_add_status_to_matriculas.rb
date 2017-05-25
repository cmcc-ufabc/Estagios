class AddStatusToMatriculas < ActiveRecord::Migration
  def change
    add_column :matriculas, :status, :integer
    add_column :matriculas, :observacao, :string
  end
end
