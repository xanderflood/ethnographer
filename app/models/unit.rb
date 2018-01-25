class Unit < ApplicationRecord
  # TODO: selectors for these
  belongs_to :medium
  belongs_to :culture
  belongs_to :transfer, required: false

  # if the hash contains an id, this will update
  # if it doesn't, a new one will be created
  accepts_nested_attributes_for :medium

  before_create :set_innoculated

  include Treeable
  inherits :culture_id

  include TreeIdentifiable
  uuid_group_field :culture_id

  private
  def set_innoculated; self.innoculated ||= Date.today; end
end
