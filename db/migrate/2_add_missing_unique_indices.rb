if ActiveRecord.gem_version >= Gem::Version.new('5.0')
  class AddMissingUniqueIndices < ActiveRecord::Migration[4.2]; end
else
  class AddMissingUniqueIndices < ActiveRecord::Migration; end
end
AddMissingUniqueIndices.class_eval do
  def self.up
    add_index :core_tags, :name, unique: true

    remove_index :core_taggings, :tag_id if index_exists?(:core_taggings, :tag_id)
    remove_index :core_taggings, [:taggable_id, :taggable_type, :context]
    add_index :core_taggings,
              [:tag_id, :taggable_id, :taggable_type, :context, :tagger_id, :tagger_type],
              unique: true, name: 'taggings_idx'
  end

  def self.down
    remove_index :core_tags, :name

    remove_index :core_taggings, name: 'taggings_idx'

    add_index :core_taggings, :tag_id unless index_exists?(:core_taggings, :tag_id)
    add_index :core_taggings, [:taggable_id, :taggable_type, :context]
  end
end
