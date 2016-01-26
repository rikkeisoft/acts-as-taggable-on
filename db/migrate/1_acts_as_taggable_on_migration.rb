class ActsAsTaggableOnMigration < ActiveRecord::Migration
  def self.up
    create_table :core_tags do |t|
      t.string :name
    end

    create_table :core_taggings do |t|
      t.references :tag

      # You should make sure that the column created is
      # long enough to store the required class names.
      t.references :taggable, polymorphic: true
      t.references :tagger, polymorphic: true

      # Limit is created to prevent MySQL error on index
      # length for MyISAM table type: http://bit.ly/vgW2Ql
      t.string :context, limit: 128

      t.datetime :created_at
    end

    add_index :core_taggings, :tag_id
    add_index :core_taggings, [:taggable_id, :taggable_type, :context]
  end

  def self.down
    drop_table :core_taggings
    drop_table :core_tags
  end
end
