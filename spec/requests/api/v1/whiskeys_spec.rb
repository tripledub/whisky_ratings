require 'rails_helper'

describe 'listing whiskeys' do
  before { get '/api/v1/whiskeys' }

  it 'returns a status code of 200' do
    expect(response).to have_http_status(:success)
  end
end
