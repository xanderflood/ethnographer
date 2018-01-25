class Unit < ApplicationRecord
  # TODO: selectors for these
  belongs_to :medium
  belongs_to :culture

  # if the hash contains an id, this will update
  # if it doesn't, a new one will be created
  accepts_nested_attributes_for :medium

  include Treeable
  inherits :culture_id

  include TreeIdentifiable
  uuid_group_field :culture_id
end
