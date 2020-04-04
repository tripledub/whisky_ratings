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
    it 'contains whiskey_one' do
      expect(json.first['title']).to eq(whiskey_one.title)
    end

    it 'contains whiskey_two' do
      expect(json.last['title']).to eq(whiskey_two.title)
    end
  end
end

describe 'creating a new whiskey' do
  let(:title) { 'Ardbeg Uigeadail, 54.2%' }
  let(:whiskey) do
    {
      title: title,
      description: 'With the Ardbeg 17 year old off the market, it’s nice to see a new Ardbeg in the line-up.',
      taste: 5,
      color: 5,
      smokiness: 5
    }
  end

  context 'when the request is valid' do
    before { post '/api/v1/whiskeys', params: { whiskey: whiskey } }

    it 'creates a whiskey' do
      expect(json['title']).to eq('Ardbeg Uigeadail, 54.2%')
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(201)
    end
  end

  context 'when the request is not valid' do
    let(:title) { nil }
    before { post '/api/v1/whiskeys', params: { whiskey: whiskey } }

    it 'returns status code 422' do
      expect(response).to have_http_status(422)
    end
  end
end
