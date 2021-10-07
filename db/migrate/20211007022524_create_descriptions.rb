class CreateDescriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :descriptions do |t|
      t.string  :title
      t.text    :comment
      t.integer :language1
      t.integer :language2
      t.integer :language3
      t.integer :language4
      t.integer :language5
      t.integer :user_id
      t.timestamps
    end
  end
end
