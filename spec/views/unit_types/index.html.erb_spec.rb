require 'rails_helper'

RSpec.describe "unit_types/index", type: :view do
  before(:each) do
    assign(:unit_types, [
      UnitType.create!(
        :name => "Name",
        :substrate => "Substrate",
        :comments => "MyText"
      ),
      UnitType.create!(
        :name => "Name",
        :substrate => "Substrate",
        :comments => "MyText"
      )
    ])
  end

  it "renders a list of unit_types" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Substrate".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
