class Culture < ApplicationRecord
  validate :collected_date_cannot_be_in_the_future

  has_many :units

  # callbacks
  def collected_date_cannot_be_in_the_future
    errors.add(:collected, "cannot be in the future") if self.collected && self.collected > Date.today
  end

  def initial_units
    self.units.where(parent: nil)
  end
end
