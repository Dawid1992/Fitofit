require 'rails_helper'

RSpec.describe ActivitiesController, type: :controller do
  include Devise::Test::ControllerHelpers

  it 'has a valid factory' do
    expect(FactoryBot.create(:activity)).to be_valid
    expect(FactoryBot.create(:user)).to be_valid
  end

  let(:user) { FactoryBot.create(:user) }
  before { sign_in user }

  let(:activity) { FactoryBot.create(:activity, user_id: user.id) }
  subject { activity }

  describe 'GET #index' do
    before :each do
      get :index
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do
    let(:action) do
      post :create, params: { activity: {
        address1: 'Plac Europejski 2, Warszawa, Polska',
        address2: 'Szprotawska 130, Warszawa, Polska'
      } }
    end

    context 'with invalid attributes' do
      let(:action) do
        post :create, params: { activity: {
          address1: 'fdhhdfhdf, sdfsdf, Polska',
          address2: 'cbxffd, dfg4, bnvv'
        } }
      end
      it "doesn't create a new activity" do
        expect { action }.to_not change { Activity.count }
      end

      it 're-renders the new method' do
        action
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #show' do
    let(:another_user) { FactoryBot.create(:user) }

    before :each do
      get :show, params: { id: activity.id }
    end

    it 'renders the :show view' do
      expect(response).to render_template(:show)
    end

    it 'calculates distance' do
      FactoryBot.create(:activity, user_id: user.id, created_at: 10.days.ago)
      FactoryBot.create(:activity, user_id: user.id)
      get :show, params: { id: activity.id }
      expect(assigns(:weekly)).to eq(activity.distance * 2)
    end
  end
end
