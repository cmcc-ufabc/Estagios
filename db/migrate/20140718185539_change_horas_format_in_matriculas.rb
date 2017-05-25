class ChangeHorasFormatInMatriculas < ActiveRecord::Migration
  def change
   change_column :matriculas, :horas, :string
  end
end
