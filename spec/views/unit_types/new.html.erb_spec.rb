require 'rails_helper'

RSpec.describe "unit_types/new", type: :view do
  before(:each) do
    assign(:unit_type, UnitType.new(
      :name => "MyString",
      :substrate => "MyString",
      :comments => "MyText"
    ))
  end

  it "renders new unit_type form" do
    render

    assert_select "form[action=?][method=?]", unit_types_path, "post" do

      assert_select "input[name=?]", "unit_type[name]"

      assert_select "input[name=?]", "unit_type[substrate]"

      assert_select "textarea[name=?]", "unit_type[comments]"
    end
  end
end
