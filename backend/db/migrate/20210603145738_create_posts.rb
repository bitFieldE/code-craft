class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false
      t.string :title, null: false, :limit => 50
      t.float :rate, null: false
      t.text :content

      t.timestamps
    end
  end
end
