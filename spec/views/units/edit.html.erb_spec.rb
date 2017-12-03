require 'rails_helper'

RSpec.describe "units/edit", type: :view do
  before(:each) do
    @unit = assign(:unit, Unit.create!(
      :uuid => "MyString",
      :weight => 1.5,
      :unit_type => nil,
      :culture => nil,
      :parent => nil,
      :comments => "MyText"
    ))
  end

  it "renders the edit unit form" do
    render

    assert_select "form[action=?][method=?]", unit_path(@unit), "post" do

      assert_select "input[name=?]", "unit[uuid]"

      assert_select "input[name=?]", "unit[weight]"

      assert_select "input[name=?]", "unit[unit_type_id]"

      assert_select "input[name=?]", "unit[culture_id]"

      assert_select "input[name=?]", "unit[parent_id]"

      assert_select "textarea[name=?]", "unit[comments]"
    end
  end
end
