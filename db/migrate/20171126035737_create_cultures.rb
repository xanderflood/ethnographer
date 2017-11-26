class CreateCultures < ActiveRecord::Migration[5.1]
  def change
    create_table :cultures do |t|
      t.string :name
      t.date :collected
      t.text :comments
      t.string :species

      t.timestamps
    end
  end
end
