require 'rails_helper'

RSpec.describe Whiskey, type: :model do
  describe 'validations' do
    let(:whiskey) { create(:whiskey) }

    it 'is not valid without a title' do
      whiskey.title = nil
      expect(whiskey.valid?).to eq(false)
    end
  end

  describe 'scopes' do
    let(:tasty_whiskey) { create(:whiskey, title: 'Tasty', taste: 5) }
    let(:smoky_whiskey) { create(:whiskey, title: 'Smoky', smokiness: 5) }
    let(:colorful_whiskey) { create(:whiskey, title: 'Colorful', color: 5) }

    describe '.minimum_color' do
      subject { Whiskey.all.minimum_color(3) }

      it { is_expected.to include(colorful_whiskey) }
      it { is_expected.to_not include(smoky_whiskey) }
      it { is_expected.to_not include(tasty_whiskey) }
    end

    describe '.minimum_taste' do
      subject { Whiskey.all.minimum_taste(3) }

      it { is_expected.to_not include(colorful_whiskey) }
      it { is_expected.to_not include(smoky_whiskey) }
      it { is_expected.to include(tasty_whiskey) }
    end

    describe '.minimum_color' do
      subject { Whiskey.all.minimum_smokiness(3) }

      it { is_expected.to_not include(colorful_whiskey) }
      it { is_expected.to include(smoky_whiskey) }
      it { is_expected.to_not include(tasty_whiskey) }
    end
  end
end
