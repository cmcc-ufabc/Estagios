class CreateFormularios < ActiveRecord::Migration
  def change
    create_table :formularios do |t|
      t.boolean :resposta_2
      t.boolean :resposta_3
      t.boolean :resposta_4
      t.boolean :resposta_5
      

      t.timestamps
    end
  end
end
