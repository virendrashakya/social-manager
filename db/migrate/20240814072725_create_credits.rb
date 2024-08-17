class CreateCredits < ActiveRecord::Migration[7.0]
  def change
    create_table :credits, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.integer :amount

      t.timestamps
    end
  end
end
