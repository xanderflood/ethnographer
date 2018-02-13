require 'rails_helper'

RSpec.describe TransfersController, type: :controller do
  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET new" do

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    context "when successful" do
      before(:each) do
        @culture = FactoryBot.create(:culture)
        @medium  = FactoryBot.create(:medium)
        transfer_params = {
          kind: :tissue,
          culture_id: @culture.id,
          medium_id: @medium.id,
          count: 1
        }

        post :create, params: { transfer: transfer_params }
      end

      it "creates the transfer" do
        expect(Transfer.count).to eq(1)
        expect(Transfer.first.medium).to eq @medium
        expect(Transfer.first.culture).to eq @culture
      end

      it "redirects to index" do
        expect(response).to redirect_to([:transfers])
      end
    end

    context "when unsuccessful" do
      before(:each) do
        post :create, params: { transfer: {} }
      end

      it "renders the new template" do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      transfer = FactoryBot.create(:transfer)
      @transfer2 = FactoryBot.create(:transfer)
      delete :destroy, params: { id: transfer.id }
    end

    it "destroys the template" do
      expect(Transfer.all).to eq [@transfer2]
    end

    it "redirects to index" do
      expect(response).to redirect_to([:transfers])
    end
  end
end
