class AddCamposToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :nome, :string
    add_column :usuarios, :tipo, :string
    add_column :usuarios, :ra, :string
  end
end
