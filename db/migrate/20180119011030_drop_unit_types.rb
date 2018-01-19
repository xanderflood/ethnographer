class DropUnitTypes < ActiveRecord::Migration[5.1]
  def change
    drop_table :unit_types
  end
end
