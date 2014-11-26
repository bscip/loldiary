class CreateTableChampions < ActiveRecord::Migration
  def change
    create_table :champions do |t|
      t.integer :riot_id
      t.string  :riot_key
      t.string  :name
      t.string  :redis_key
      t.timestamps
    end
  end
end
