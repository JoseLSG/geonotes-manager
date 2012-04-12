class AddForeignKeysToUsers < ActiveRecord::Migration
  def self.up
      add_column :notes, :region_id, :integer
      add_column :notes, :local_id, :integer
  end

  def self.down
    remove_column :notes, :region_id
    remove_column :notes, :local_id
  end
end
