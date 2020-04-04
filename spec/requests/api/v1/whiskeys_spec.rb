require 'rails_helper'

describe 'listing whiskeys' do
  let!(:whiskey_one) do
    create(:whiskey, title: 'Bowmore 46 year old (distilled 1964), 42.9%')
  end

  let!(:whiskey_two) do
    create(:whiskey, title: 'Glenfarclas Family Casks 1954 Cask #1260, 47.2%')
  end

  before { get '/api/v1/whiskeys' }

  it 'returns a status code of 200' do
    expect(response).to have_http_status(:success)
  end

  describe 'returned results' do
    subject { JSON.parse(response.body) }

    it 'contains whiskey_one' do
      expect(subject.first['title']).to eq(whiskey_one.title)
    end

    it 'contains whiskey_two' do
      expect(subject.last['title']).to eq(whiskey_two.title)
    end
  end
end
