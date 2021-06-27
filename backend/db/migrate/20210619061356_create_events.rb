class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.string :title, null: false, :limit => 50
      t.string :place, null: false
      t.text :content, null: false, :limit => 1000
      t.integer :participant_number, null: false, :maximum => 50
      t.date :scheduled_date, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false

      t.timestamps
    end
  end
end
