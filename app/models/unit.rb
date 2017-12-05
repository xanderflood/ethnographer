class Unit < ApplicationRecord
  # TODO: selectors for these
  belongs_to :unit_type
  belongs_to :culture
  belongs_to :parent, class_name: :Unit, required: false

  validate :same_culture_as_parent

  before_save :set_uuid

  # if the hash contains an id, this will update
  # if it doesn't, a new one will be created, even
  # if there's a match in name
  accepts_nested_attributes_for :unit_type

  def original?; self.parent.present?; end

  def generation
    return 0 unless self.parent.present?

    # load your ancestors in one query
    # TODO: make this work
    Unit.preload(Unit.last.parent_id).includes(parent: :parent)

    cur = self.parent
    i   = 0
    until cur.nil?
      cur = cur.parent
      i  += 1
    end

    return i
  end

  def innoc_date_str
    "" unless self.innoculated?
    @innoc_date_str ||= self.innoculated.strftime("%d.%m.%Y")
  end

  private

  ### callbacks ###
  def same_culture_as_parent
    self.culture_id = self.parent.culture_id if self.parent.present?
  end

  # TODO: put this in a concern?
  def num_uuuid s; Unit.where("uuid LIKE ?", "#{s}%").count; end
  def set_uuid
    self.uuid = if self.innoculated?
      start = "#{self.innoc_date_str}-#{self.culture_id}-#{self.unit_type.name}"
      "#{start}-#{to_alpha num_uuuid(start)}"
    else
      "blank-#{self.id}"
    end
  end

  # helpers
  def to_alpha num
    s = ""
    a = ("a".."z").to_a
    while num > 0
      s   = s + a[num % 26]
      num = num / 26
    end
    s
  end
end
