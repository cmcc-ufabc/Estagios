class CreatePeriodos < ActiveRecord::Migration
  def change
    create_table :periodos do |t|
      t.date :matricula_inicio
      t.date :matricula_fim
      t.date :reajuste_inicio
      t.date :reajuste_fim

      t.timestamps
    end
  end
end
