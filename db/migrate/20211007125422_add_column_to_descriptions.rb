class AddColumnToDescriptions < ActiveRecord::Migration[6.1]
  def change
    add_column :descriptions, :github, :string
    add_column :descriptions, :facebook, :string
    add_column :descriptions, :qiita, :string
    add_column :descriptions, :note, :string
    add_column :descriptions, :site, :string
  end
end
