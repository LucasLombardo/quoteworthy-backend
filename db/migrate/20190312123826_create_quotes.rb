class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.text :body, null: false
      t.string :attribution, null: false

      t.timestamps
    end
  end
end
