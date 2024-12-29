class AddBrowserAndDeviceToClicks < ActiveRecord::Migration[8.0]
  def change
    add_column :clicks, :browser, :string
  end
end
