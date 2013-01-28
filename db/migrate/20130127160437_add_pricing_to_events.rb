class AddPricingToEvents < ActiveRecord::Migration
  def change
    add_column :events, :price, :string
    add_column :events, :ticket_link, :string
  end
end
