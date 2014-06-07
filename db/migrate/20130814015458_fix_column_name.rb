class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :museums, :museum, :name
  end
end
