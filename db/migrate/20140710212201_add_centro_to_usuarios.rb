class AddCentroToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :centro, :string
    add_column :usuarios, :telefone, :string
  end
end
