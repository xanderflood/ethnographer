require 'rails_helper'

RSpec.describe "unit_types/show", type: :view do
  before(:each) do
    @unit_type = assign(:unit_type, UnitType.create!(
      :name => "Name",
      :substrate => "Substrate",
      :comments => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Substrate/)
    expect(rendered).to match(/MyText/)
  end
end
