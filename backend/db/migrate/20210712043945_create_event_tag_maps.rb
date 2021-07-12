class CreateEventTagMaps < ActiveRecord::Migration[6.1]
  def change
    create_table :event_tag_maps do |t|
      t.references :event, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
