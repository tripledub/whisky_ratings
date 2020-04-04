require 'rails_helper'

RSpec.describe Whiskey, type: :model do
  describe 'validations' do
    let(:whiskey) { create(:whiskey) }

    it 'is not valid without a title' do
      whiskey.title = nil
      expect(whiskey.valid?).to eq(false)
    end
  end
end
