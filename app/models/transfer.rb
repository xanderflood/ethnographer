class Transfer < ApplicationRecord
  belongs_to :parent, class_name: :Unit, required: false
  belongs_to :culture, required: false
  belongs_to :medium

  has_many :units

  enum kind: { transfer: 0, tissue: 1, spores: 2, isolate: 3 }
  # :transfer moving mycelia from one Unit to another of the same culture
  # :clone    growing a tissue sample from a fruiting body
  # :spores   plating spores to produce many new cultures
  # :isolate  renaming an isolate from a non-pure culture

  attr_accessor :count

  # can only be used to create, not update
  accepts_nested_attributes_for :medium
  accepts_nested_attributes_for :culture

  after_create :do_transfer

  validate :maybe_require_parent
  validate :maybe_require_culture

  # TODO: tissue samples must have culture or culture_attributes
  #       transfer kinds must *not* have these

  private
  def do_transfer
    case type
    when :transfer
      raise StandardError.new("Not yet implemented.")

      # TODO: create `count` many children of `parent`, using `medium`
    when :tissue
      raise StandardError.new("Not yet implemented.")

      # TODO: create `count` top-level units of `culture`, using `medium`
    when :spores
      raise StandardError.new("Not yet implemented.")
    when :isolate
      raise StandardError.new("Not yet implemented.")
    else
      raise StandardError.new("Invalid transfer kind.")
    end
  end

  def maybe_require_parent
    if self.transfer?
      errors.add(:parent, "must be specified") unless self.parent_id
    end
  end

  def maybe_require_culture
    if self.tissue?
      errors.add(:culture, "must be specified") unless self.culture
    end
  end
end
