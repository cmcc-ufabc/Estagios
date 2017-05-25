class CreateAprovas < ActiveRecord::Migration
  def change
    create_table :aprovas do |t|
      t.string :tipo

      t.timestamps
    end
  end
end
