class Unit < ApplicationRecord
  # TODO: selectors for these
  belongs_to :medium
  belongs_to :culture
  belongs_to :parent, class_name: :Unit, required: false
  has_many :children, class_name: :Unit, foreign_key: :parent_id

  before_create :set_uuid
  before_save   :set_culture

  # if the hash contains an id, this will update
  # if it doesn't, a new one will be created
  accepts_nested_attributes_for :medium

  scope :initial, -> { where(parent: nil) }
  def initial?; parent.nil?; end

  def generation
    if initial?
      0
    elsif !persisted?
      self.parent.generation + 1
    else
      Unit.ancestral_line_for(self).count
    end
  end

  def innoc_date_str
    "" unless self.innoculated?
    @innoc_date_str ||= self.innoculated.strftime("%d.%m.%Y")
  end

  private
  ### callbacks ###
  def set_culture
    self.culture_id = self.parent.culture_id if self.parent.present?
  end

  # TODO: put this in a concern?
  # this is called _before_ saving this unit
  def num_uuuid; Unit.where(parent: self.parent).count; end
  def set_uuid
    g = self.generation

    start = if self.parent
      self.parent.uuid
    else
      "#{self.culture_id}-#{self.innoc_date_str}-"
    end

    n = num_uuuid
    c = Unit.to_alpha(n)

    "#{start}#{c}"
  end

  # helpers
  def self.to_alpha num
    s = ""
    a = ("a".."z").to_a
    while num > 0
      s   = s + a[num % 26]
      num = num / 26
    end
    s
  end

  ### class methods ###
  # TODO: factor these tree queries into a concern, or even a gem
  # these require the unit to be persisted
  def self.descendents_tree_for(instance)
    self.where("#{table_name}.id IN (#{descendants_sql_for(instance)})")
        .order("#{table_name}.id")
  end

  def self.ancestral_line_for(instance)
    self.where("#{table_name}.id IN (#{ancestors_sql_for(instance)})")
        .order("#{table_name}.id")
  end

  def self.descendants_sql_for(instance)
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

  def self.ancestors_sql_for(instance)
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
