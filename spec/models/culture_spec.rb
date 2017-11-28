require 'rails_helper'

RSpec.describe Culture, type: :model do
  it 'should reject a culture collected in the future' do
    expect do
      Culture.create!(collected: Date.today + 1)
    end.to raise_error ActiveRecord::RecordInvalid
  end
end
