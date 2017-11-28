require 'rails_helper'

RSpec.describe "cultures/new", type: :view do
  before(:each) do
    assign(:culture, FactoryBot.create(:culture))
  end

  it "renders new culture form" do
    render

    assert_select "form", cultures_path, "post" do

      assert_select "input[name=?]", "culture[name]"

      assert_select "input[name=?]", "culture[species]"

      assert_select "textarea[name=?]", "culture[comments]"
    end
  end
end
