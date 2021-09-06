class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.string :address1
      t.string :address2
      t.float :distance

      t.timestamps
    end
  end
end
