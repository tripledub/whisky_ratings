require 'rails_helper'

RSpec.describe WhiskeyFinder do
  let!(:tasty_whiskey) { create(:whiskey, title: 'Tasty', taste: 3) }
  let!(:smoky_whiskey) { create(:whiskey, title: 'Smoky', smokiness: 3) }
  let!(:colorful_whiskey) { create(:whiskey, title: 'Colorful', color: 3) }

  let!(:very_tasty_whiskey) { create(:whiskey, title: 'Very Tasty', taste: 5) }

  let!(:very_smoky_whiskey) do
    create(:whiskey, title: 'Very Smoky', description: 'Real Smoky', smokiness: 5)
  end
  let!(:very_colorful_whiskey) { create(:whiskey, title: 'Very Colorful', color: 5) }

  let(:query) { '' }
  let(:color) { '' }
  let(:taste) { '' }
  let(:smokiness) { '' }

  let(:search_params) do
    {
      query: query,
      color: color,
      taste: taste,
      smokiness: smokiness
    }
  end

  subject { described_class.search(search_params) }

  context 'with all empty params' do
    it 'returns all results' do
      expect(subject.size).to eq(6)
    end
  end

  describe 'Text search' do
    context 'when the query is "Tasty"' do
      let(:query) { 'Tasty' }

      it 'returns both the tasty whiskeys' do
        expect(subject).to match_array([tasty_whiskey, very_tasty_whiskey])
      end
    end

    context 'when the query is "Tasty"' do
      let(:query) { 'Very Tasty' }

      it 'returns only the very tasty whiskey' do
        expect(subject).to match_array([very_tasty_whiskey])
      end
    end

    context 'when the query is "Real Smoky"' do
      let(:query) { 'Real Smoky' }

      it 'returns only the very tasty whiskey based on description' do
        expect(subject).to match_array([very_smoky_whiskey])
      end
    end

    describe 'case insensitive search' do
      context 'when the query is "tasty"' do
        let(:query) { 'tasty' }

        it 'returns both the tasty whiskeys' do
          expect(subject).to match_array([tasty_whiskey, very_tasty_whiskey])
        end
      end

      context 'when the query is "TASTY"' do
        let(:query) { 'TASTY' }

        it 'returns both the tasty whiskeys' do
          expect(subject).to match_array([tasty_whiskey, very_tasty_whiskey])
        end
      end
    end
  end

  describe 'Searching characteristics' do
    context 'any color above 2' do
      let(:color) { 2 }

      it 'returns both colorful whiskeys' do
        expect(subject).to match_array([colorful_whiskey, very_colorful_whiskey])
      end
    end

    context 'any color above 4' do
      let(:color) { 4 }

      it 'only returns the very colorful whiskeys' do
        expect(subject).to match_array([very_colorful_whiskey])
      end
    end

    context 'any taste above 2' do
      let(:taste) { 2 }

      it 'returns both tasty whiskeys' do
        expect(subject).to match_array([tasty_whiskey, very_tasty_whiskey])
      end
    end

    context 'any taste above 4' do
      let(:taste) { 4 }

      it 'only returns the very tasty whiskeys' do
        expect(subject).to match_array([very_tasty_whiskey])
      end
    end

    context 'any smokiness above 2' do
      let(:smokiness) { 2 }

      it 'returns both smoky whiskeys' do
        expect(subject).to match_array([smoky_whiskey, very_smoky_whiskey])
      end
    end

    context 'any smokiness above 4' do
      let(:smokiness) { 4 }

      it 'only returns the very smoky whiskeys' do
        expect(subject).to match_array([very_smoky_whiskey])
      end
    end
  end
end
