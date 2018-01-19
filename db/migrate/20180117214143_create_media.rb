class CreateMedia < ActiveRecord::Migration[5.1]
  def change
    create_table :media do |t|
      t.string :name
      t.text :recipe

      t.timestamps
    end
  end
end
