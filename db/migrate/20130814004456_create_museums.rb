class CreateMuseums < ActiveRecord::Migration
  def change
    create_table :museums do |t|
      t.string :museum
      t.string :website

      t.timestamps
    end
  end
end
