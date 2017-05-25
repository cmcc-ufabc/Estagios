class AddPeriodoIdToAvisos < ActiveRecord::Migration
  def change
    add_column :avisos, :periodo_id, :integer
  end
end
