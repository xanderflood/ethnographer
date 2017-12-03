class CreateUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :units do |t|
      t.string :uuid
      t.float :weight
      t.references :unit_type, foreign_key: true
      t.date :prepared
      t.date :innoculated
      t.date :disposed
      t.references :culture, foreign_key: true
      t.references :parent, references: :units
      t.foreign_key :units, column: :parent_id
      t.text :comments

      t.timestamps
    end
  end
end
