class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules, id: :uuid do |t|
      t.references :post, null: false, foreign_key: true, type: :uuid
      t.datetime :scheduled_time
      t.string :status

      t.timestamps
    end
  end
end
