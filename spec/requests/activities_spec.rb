require 'rails_helper'

RSpec.describe 'Activities', type: :request do
  let(:user) { create(:user) }
  let!(:activity) { create(:activity) }

  context 'when the user is not logged in' do
    it 'redirects to login page when guest try to access activities index' do
      get(activities_path)
      expect(response).to redirect_to('/users/sign_in')
      follow_redirect!
      expect(response.body).to include('Log in')
    end
  end

  context 'when the user is logged in' do
    before do
      sign_in user
    end

    it 'renders activity index page that contains activities' do
      get(activities_path)
      expect(response.body).to include('Your monthly statistics')
    end

    it "returns 404 when activity doesn't exist" do
      expect { get(activity_path(30)) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
