class AddMissingTaggableIndex < ActiveRecord::Migration
  def self.up
    add_index :core_taggings, [:taggable_id, :taggable_type, :context]
  end

  def self.down
    remove_index :core_taggings, [:taggable_id, :taggable_type, :context]
  end
end
