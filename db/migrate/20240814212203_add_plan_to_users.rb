class AddPlanToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :plan, null: false, foreign_key: true, type: :uuid
    add_column :users, :balance, :decimal, default: 0.0, null: false
  end
end
