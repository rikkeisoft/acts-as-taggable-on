if ActiveRecord.gem_version >= Gem::Version.new('5.0')
  class AddMissingIndexesOnTaggings < ActiveRecord::Migration[4.2]; end
else
  class AddMissingIndexesOnTaggings < ActiveRecord::Migration; end
end
AddMissingIndexesOnTaggings.class_eval do
  def change
    add_index :core_taggings, :tag_id unless index_exists? :core_taggings, :tag_id
    add_index :core_taggings, :taggable_id unless index_exists? :core_taggings, :taggable_id
    add_index :core_taggings, :taggable_type unless index_exists? :core_taggings, :taggable_type
    add_index :core_taggings, :tagger_id unless index_exists? :core_taggings, :tagger_id
    add_index :core_taggings, :context unless index_exists? :core_taggings, :context

    unless index_exists? :core_taggings, [:tagger_id, :tagger_type]
      add_index :core_taggings, [:tagger_id, :tagger_type]
    end

    unless index_exists? :core_taggings, [:taggable_id, :taggable_type, :tagger_id, :context], name: 'taggings_idy'
      add_index :core_taggings, [:taggable_id, :taggable_type, :tagger_id, :context], name: 'taggings_idy'
    end
  end
end
