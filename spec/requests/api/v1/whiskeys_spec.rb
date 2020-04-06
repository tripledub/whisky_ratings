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

    it 'returns a validation failure message' do
      expect(response.body)
        .to match(/Validation failed: Title can't be blank/)
    end
  end
end

describe 'viewing a whiskey' do
  let!(:whiskey) do
    create(:whiskey, title: 'Bowmore 46 year old (distilled 1964), 42.9%')
  end

  let(:whiskey_id) { whiskey.id }

  before { get "/api/v1/whiskeys/#{whiskey_id}" }

  context 'when the record exists' do
    it 'returns the whiskey' do
      expect(json).not_to be_empty
      expect(json['id']).to eq(whiskey_id)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  context 'when the record does not exist' do
    let(:whiskey_id) { 100 }

    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end

    it 'returns a not found message' do
      expect(response.body).to match(/Couldn't find Whiskey/)
    end
  end
end

describe 'searching whiskeys' do
  let!(:whiskey_one) do
    create(
      :whiskey,
      title: 'Bowmore 46 year old (distilled 1964), 42.9%',
      description: 'Bowmore 46 year old (distilled 1964), 42.9%'
    )
  end

  let!(:whiskey_two) do
    create(
      :whiskey,
      title: 'Glenfarclas Family Casks 1954 Cask #1260, 47.2%',
      description: 'Glenfarclas Family Casks 1954 Cask #1260, 47.2%'
    )
  end

  let(:query) { 'Bowmore' }

  let(:search_params) do
    { search: { query: query, color: 0, smokiness: nil, taste: nil } }
  end

  before { get '/api/v1/whiskeys/search', params: search_params }

  describe 'returned results' do
    it 'contains whiskey_one' do
      expect(json.first['title']).to eq(whiskey_one.title)
    end
  end
end
