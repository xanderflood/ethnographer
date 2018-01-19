require 'rails_helper'

RSpec.describe Culture, type: :model do
  it 'should accept valid attributes' do
    expect do
      Culture.create!(collected: Date.today - 1)
    end.not_to raise_error
  end

  it 'should reject a culture collected in the future' do
    expect do
      Culture.create!(collected: Date.today + 1)
    end.to raise_error ActiveRecord::RecordInvalid
  end
end
