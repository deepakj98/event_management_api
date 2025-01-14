class AddPriceToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :price, :bigint
  end
end
