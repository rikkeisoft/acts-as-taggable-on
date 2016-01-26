class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :core_taggings, :tag_id
    add_index :core_taggings, :taggable_id
    add_index :core_taggings, :taggable_type
    add_index :core_taggings, :tagger_id
    add_index :core_taggings, :context

    add_index :core_taggings, [:tagger_id, :tagger_type]
    add_index :core_taggings, [:taggable_id, :taggable_type, :tagger_id, :context], name: 'taggings_idy'
  end
end
