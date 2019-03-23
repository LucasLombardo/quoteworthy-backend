class CreateAttributions < ActiveRecord::Migration[5.2]
  def change
    create_table :attributions do |t|
        t.string :name
        t.timestamps
    end

    add_reference :quotes, :attribution, foreign_key: true
  end
end
