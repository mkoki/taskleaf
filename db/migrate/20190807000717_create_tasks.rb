class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :time
      t.boolean :finished, default: false, null: false

      t.timestamps
    end
  end
end
