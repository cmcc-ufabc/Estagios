class CreateDssirelatorios < ActiveRecord::Migration
  def change
    create_table :dssirelatorios do |t|
      t.string :dataenvio
      t.string :aluno
      t.string :matricula_id
      t.string :ci

      t.timestamps
    end
  end
end
