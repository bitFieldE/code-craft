class CreateJoinEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :join_events do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps

      t.index %i[user_id event_id], unique: true
    end
  end
end
