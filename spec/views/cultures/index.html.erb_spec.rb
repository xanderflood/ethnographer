require 'rails_helper'

RSpec.describe "cultures/index", type: :view do
  before(:each) do
    @culture = assign(:cultures, [
      FactoryBot.create(:culture),
      FactoryBot.create(:culture)
    ])
  end

  it "renders a list of cultures" do
    render
    assert_select "tr>td.name", :count => 2
    assert_select "tr>td.species", :count => 2
    assert_select "tr>td.comments", :count => 2
  end
end
