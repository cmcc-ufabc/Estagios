class CreateDocentes < ActiveRecord::Migration
  def change
    create_table :docentes do |t|
      t.string :docente
      t.string :centro
      t.string :email
      t.string :ramal

      t.timestamps
    end
  end
end
