class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :plan
      t.string :status
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
