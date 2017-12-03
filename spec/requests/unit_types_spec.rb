require 'rails_helper'

RSpec.describe "UnitTypes", type: :request do
  describe "GET /unit_types" do
    it "works! (now write some real specs)" do
      get unit_types_path
      expect(response).to have_http_status(200)
    end
  end
end
