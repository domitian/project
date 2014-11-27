class AddRolePriorityToRole < ActiveRecord::Migration
  def change
    add_column :roles, :role_priority, :integer
  end
end
