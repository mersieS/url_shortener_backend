class AddLocationToClicks < ActiveRecord::Migration[8.0]
  def change
    add_column :clicks, :country, :string
    add_column :clicks, :city, :string
  end
end
