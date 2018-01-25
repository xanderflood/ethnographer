class Unit < ApplicationRecord
  # TODO: selectors for these
  belongs_to :medium
  belongs_to :culture

  before_create :set_uuid

  # if the hash contains an id, this will update
  # if it doesn't, a new one will be created
  accepts_nested_attributes_for :medium

  include Treeable
  inherits :culture_id

  def innoc_date_str
    "" unless self.innoculated?
    @innoc_date_str ||= self.innoculated.strftime("%d.%m.%Y")
  end

  private
  ### callbacks ###
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
    c = (g % 2 == 0) ? Unit.to_alpha(n) : n

    self.uuid = "#{start}#{c}"
  end

  # helpers
  def self.to_alpha num
    str = ""
    chars = ("A".."Z").to_a
    loop do
      str = str + chars[(num % 26)]
      num = num / 26
      break if num == 0
    end
    str
  end
end
