class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :name, null: false, :limit => 25

      t.timestamps
    end
  end
end
