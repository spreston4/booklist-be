class CreateReadlists < ActiveRecord::Migration[7.0]
  def change
    create_table :readlists do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    create_join_table :readlists, :books
  end
end
