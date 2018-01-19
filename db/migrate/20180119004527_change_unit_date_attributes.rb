class ChangeUnitDateAttributes < ActiveRecord::Migration[5.1]
  def change
    remove_column :units, :prepared
    change_column :units, :disposed, :date, null: true
    remove_column :units, :unit_type_id
  end
end
