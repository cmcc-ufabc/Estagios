class AddRegistradorCiToPeriodos < ActiveRecord::Migration
  def change
    add_column :periodos, :registrador_ci, :integer
  end
end
