class CreateClicks < ActiveRecord::Migration[8.0]
  def change
    create_table :clicks do |t|
      t.string :ip_address
      t.references :url, null: false, foreign_key: true

      t.timestamps
    end
  end
end
