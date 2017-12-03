require 'rails_helper'

RSpec.describe "units/new", type: :view do
  before(:each) do
    assign(:unit, Unit.new(
      :uuid => "MyString",
      :weight => 1.5,
      :unit_type => nil,
      :culture => nil,
      :parent => nil,
      :comments => "MyText"
    ))
  end

  it "renders new unit form" do
    render

    assert_select "form[action=?][method=?]", units_path, "post" do

      assert_select "input[name=?]", "unit[uuid]"

      assert_select "input[name=?]", "unit[weight]"

      assert_select "input[name=?]", "unit[unit_type_id]"

      assert_select "input[name=?]", "unit[culture_id]"

      assert_select "input[name=?]", "unit[parent_id]"

      assert_select "textarea[name=?]", "unit[comments]"
    end
  end
end
