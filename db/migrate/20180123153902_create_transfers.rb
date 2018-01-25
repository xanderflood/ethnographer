class CreateTransfers < ActiveRecord::Migration[5.1]
  def change
    create_table :transfers do |t|
      t.datetime :datetime
      t.integer :kind, null: false, default: 0
      t.text :notes

      t.references :parent, references: :units
      t.references :medium, foreign_key: true
      t.references :culture, foreign_key: true

      t.timestamps
    end

    add_foreign_key :transfers, :units, column: :parent_id

    add_column :units, :transfer_id, :bigint
  end
end
