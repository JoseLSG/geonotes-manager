class CreateNotesTags < ActiveRecord::Migration
  def self.up
     create_table :notes_tags, :id => false do |t|
      t.integer :note_id
      t.integer :tag_id
    end
  end

  def self.down
    drop_table :notes_tags
  end
end
