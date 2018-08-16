class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.text :body
      t.text :slug

      t.timestamps
    end
    add_index :blogs, :slug, unique: true
  end
end
