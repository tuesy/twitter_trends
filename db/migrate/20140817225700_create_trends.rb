class CreateTrends < ActiveRecord::Migration
  def change
    create_table :trends do |t|
      t.datetime :as_of
      t.string :location
      t.integer :woeid
      t.string :name
      t.string :query
      t.string :url
      t.timestamps
    end
  end
end
