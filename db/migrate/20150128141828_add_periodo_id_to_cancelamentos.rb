class AddPeriodoIdToCancelamentos < ActiveRecord::Migration
  def change
    add_column :cancelamentos, :periodo_id, :string
  end
end
