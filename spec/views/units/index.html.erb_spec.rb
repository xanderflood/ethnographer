require 'rails_helper'

RSpec.describe "units/index", type: :view do
  before(:each) do
    assign(:units, [
      Unit.create!(
        :uuid => "Uuid",
        :weight => 2.5,
        :unit_type => nil,
        :culture => nil,
        :parent => nil,
        :comments => "MyText"
      ),
      Unit.create!(
        :uuid => "Uuid",
        :weight => 2.5,
        :unit_type => nil,
        :culture => nil,
        :parent => nil,
        :comments => "MyText"
      )
    ])
  end

  it "renders a list of units" do
    render
    assert_select "tr>td", :text => "Uuid".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
