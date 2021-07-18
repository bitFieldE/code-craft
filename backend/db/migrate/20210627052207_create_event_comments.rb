class CreateEventComments < ActiveRecord::Migration[6.1]
  def change
    create_table :event_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.text :content, null: false
      t.timestamps
    end
  end
end
