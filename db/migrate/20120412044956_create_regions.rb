class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
      t.string :continent
      t.string :country
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :regions
  end
end
