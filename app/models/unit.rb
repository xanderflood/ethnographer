class Unit < ApplicationRecord
  belongs_to :unit_type
  belongs_to :culture
  belongs_to :parent, class_name: :Unit, required: false
end
