class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans, id: :uuid do |t|
      t.string :name
      t.decimal :price
      t.integer :duration

      t.timestamps
    end
  end
end
