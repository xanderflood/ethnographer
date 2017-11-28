class Culture < ApplicationRecord
  validate :collected_date_cannot_be_in_the_future

  # callbacks
  def collected_date_cannot_be_in_the_future
    errors.add(:collected, "cannot be in the future") if self.collected > Date.today
  end
end
