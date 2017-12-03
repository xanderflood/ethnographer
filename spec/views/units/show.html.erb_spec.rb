require 'rails_helper'

RSpec.describe "units/show", type: :view do
  before(:each) do
    @unit = assign(:unit, Unit.create!(
      :uuid => "Uuid",
      :weight => 2.5,
      :unit_type => nil,
      :culture => nil,
      :parent => nil,
      :comments => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Uuid/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
  end
end
