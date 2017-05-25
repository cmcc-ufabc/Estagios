class AddPeriodoIdToChamadas < ActiveRecord::Migration
  def change
    add_column :chamadas, :periodo_id, :string
  end
end
