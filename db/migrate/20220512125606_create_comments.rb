class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :text, null: false
      t.references :user, foreign_key: true
      t.references :commentable, polymorphic: true
      t.timestamps
    end
  end
end
