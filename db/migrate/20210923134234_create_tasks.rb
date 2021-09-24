class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :content
      t.datetime :deadline
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.references :team, null: true, foreign_key: true

      t.timestamps
    end
  end
end
