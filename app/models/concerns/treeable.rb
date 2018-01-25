module Treeable
  extend ActiveSupport::Concern

  included do
    default_scope -> { order(:parent_id, :id) }
    scope :initial, -> { where(parent: nil) }

    belongs_to :parent, class_name: name, required: false
    has_many :children, class_name: name, foreign_key: :parent_id
  end

  def initial?; parent.nil?; end

  def generation
    if initial?
      0
    elsif !persisted?
      self.parent.generation + 1
    else
      self.ancestors.count - 1
    end
  end

  # these all require the unit to be persisted
  def descendents
    self.class.where("#{self.class.table_name}.id IN (#{self.class.descendants_sql_for(self)})")
  end

  def ancestors
    self.class.where("#{self.class.table_name}.id IN (#{self.class.ancestors_sql_for(self)})")
  end

  class_methods do
    # declare attributes that should be inherited from the parent record
    def inherits *attributes
      after_initialize :inherit_attributes, if: :new_record?

      define_method(:inherit_attributes) do
        return if self.initial?

        attributes.each do |attrib|
          self.send(:"#{attrib}=", self.parent[attrib])
        end
      end
    end

    ### SQL queries ###
    def descendants_sql_for(instance)
      # taken from https://hashrocket.com/blog/posts/recursive-sql-in-activerecord
      <<-SQL
      WITH RECURSIVE search_tree(id, path) AS (
          SELECT id, ARRAY[id]
          FROM #{table_name}
          WHERE id = #{instance.id}
        UNION ALL
          SELECT #{table_name}.id, path || #{table_name}.id
          FROM search_tree
          JOIN #{table_name} ON #{table_name}.parent_id = search_tree.id
          WHERE NOT #{table_name}.id = ANY(path)
      )
      SELECT id FROM search_tree ORDER BY path
      SQL
    end

    def ancestors_sql_for(instance)
      # adapted from https://hashrocket.com/blog/posts/recursive-sql-in-activerecord
      <<-SQL
      WITH RECURSIVE search_tree(id, pid) AS (
          SELECT id, parent_id
          FROM #{table_name}
          WHERE id = #{instance.id}
        UNION ALL
          SELECT #{table_name}.id, #{table_name}.parent_id
          FROM search_tree
          JOIN #{table_name} ON #{table_name}.id = search_tree.pid
          WHERE NOT #{table_name}.id = #{instance.id}
      )
      SELECT id FROM search_tree
      SQL
    end
  end
end