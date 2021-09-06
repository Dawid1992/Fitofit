class AddForeignKeyToActivities < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :user_id, :integer
    add_foreign_key :activities, :users, on_delete: :cascade
  end
end
