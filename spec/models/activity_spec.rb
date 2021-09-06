require 'rails_helper'

RSpec.describe Activity, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:activity)).to be_valid
  end

  let(:activity) { FactoryBot.create(:activity) }
  subject { activity }

  describe 'validations' do
    it { expect(subject).to validate_presence_of(:address1) }
    it { expect(subject).to validate_presence_of(:address2) }
    it { expect(subject).to validate_presence_of(:distance) }
    it { expect(subject).to validate_numericality_of(:distance).is_greater_than(0) }
  end

  describe 'associations' do
    it { should belong_to :user }
  end
end
