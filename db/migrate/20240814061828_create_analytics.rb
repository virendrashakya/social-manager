class CreateAnalytics < ActiveRecord::Migration[7.0]
  def change
    create_table :analytics, id: :uuid do |t|
      t.references :post, null: false, foreign_key: true, type: :uuid
      t.integer :engagement
      t.integer :reach

      t.timestamps
    end
  end
end
