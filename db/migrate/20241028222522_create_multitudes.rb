class CreateMultitudes < ActiveRecord::Migration[7.2]
  def change
    create_table :multitudes do |t|
      t.string :title
      t.string :description
      t.string :banner
      t.string :icon

      t.timestamps
    end
  end
end
