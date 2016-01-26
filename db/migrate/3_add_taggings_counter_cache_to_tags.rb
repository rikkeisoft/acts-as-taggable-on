class AddTaggingsCounterCacheToTags < ActiveRecord::Migration
  def self.up
    add_column :core_tags, :taggings_count, :integer, default: 0

    ActsAsTaggableOn::Tag.reset_column_information
    ActsAsTaggableOn::Tag.find_each do |tag|
      ActsAsTaggableOn::Tag.reset_counters(tag.id, :core_taggings)
    end
  end

  def self.down
    remove_column :core_tags, :taggings_count
  end
end
