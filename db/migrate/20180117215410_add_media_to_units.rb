class AddMediaToUnits < ActiveRecord::Migration[5.1]
  def change
    add_reference :units, :medium, foreign_key: true
  end
end
