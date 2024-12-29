class CreateUrls < ActiveRecord::Migration[8.0]
  def change
    create_table :urls do |t|
      t.string :name
      t.string :short_url
      t.string :original_url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
