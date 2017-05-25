class CreateAvisos < ActiveRecord::Migration
  def change
    create_table :avisos do |t|
      t.string :detalhes
      t.string :autor
      t.string :titulo
      t.date :data

      t.timestamps
    end
  end
end
