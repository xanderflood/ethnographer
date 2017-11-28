require 'rails_helper'

RSpec.describe "cultures/show", type: :view do
  before(:each) do
    @culture = assign(:culture, FactoryBot.create(:culture))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(@culture.name[0..3])
    expect(rendered).to match(@culture.species)
    expect(rendered).to match(@culture.comments)
  end
end
