require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:activities) }
  end
  describe 'validations' do
    context 'email' do
      it do
        is_expected.to validate_presence_of(:email)
      end
      it do
        is_expected.to allow_values('example@test.com', 'john_smith@example.com')
          .for(:email)
      end
      it do
        is_expected.to_not allow_values('noat.com', 'just_word')
          .for(:email)
      end
    end
    context 'password' do
      it do
        is_expected.to allow_values('strongpassword123', 'radnomwordsandnumbers6356')
          .for(:password)
      end
      it do
        is_expected.to_not allow_values('hi', 'qwe', '')
          .for(:password)
      end
      it do
        is_expected.to validate_presence_of(:password)
      end
    end
    context "when password confirmation doesn't match the password" do
      let(:user) { build(:user, password: 'pass1234', password_confirmation: 'pass') }
      it 'is not valid' do
        expect(user).not_to be_valid
        expect(user.errors.messages[:password_confirmation].first).to eq "doesn't match Password"
      end
    end
  end
end
