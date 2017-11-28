require 'rails_helper'

RSpec.describe "cultures/edit", type: :view do
  before(:each) do
    @culture = FactoryBot.create(:culture)
  end

  it "renders the edit culture form" do
    render

    assert_select "form[action=?][method=?]", culture_path(@culture), "post" do

      assert_select "input[name=?]", "culture[name]"

      assert_select "input[name=?]", "culture[species]"

      assert_select "textarea[name=?]", "culture[comments]"
    end
  end
end
