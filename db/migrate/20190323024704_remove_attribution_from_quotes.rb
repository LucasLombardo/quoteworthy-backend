class RemoveAttributionFromQuotes < ActiveRecord::Migration[5.2]
  def change
    remove_column :quotes, :attribution, :string
  end
end
