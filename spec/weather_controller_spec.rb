require 'rails_helper'

RSpec.describe WeatherController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'creates a new weather forecast' do
      get :forecast, params: { address: 'New York, NY' }
      expect(response).to render_template(:forecast)
    end
  end
end