require 'rails_helper'

RSpec.describe "unit_types/edit", type: :view do
  before(:each) do
    @unit_type = assign(:unit_type, UnitType.create!(
      :name => "MyString",
      :substrate => "MyString",
      :comments => "MyText"
    ))
  end

  it "renders the edit unit_type form" do
    render

    assert_select "form[action=?][method=?]", unit_type_path(@unit_type), "post" do

      assert_select "input[name=?]", "unit_type[name]"

      assert_select "input[name=?]", "unit_type[substrate]"

      assert_select "textarea[name=?]", "unit_type[comments]"
    end
  end
end
