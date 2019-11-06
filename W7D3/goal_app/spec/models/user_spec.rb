require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'validations' do
    it { should validate_presence_of(:username) }

    describe 'uniqueness' do 
      before(:each) { create(:user) }
      it { should validate_uniqueness_of(:username) }
    end

    it { should validate_presence_of(:password_digest) }

    it { should validate_presence_of(:session_token) }

    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe 'associations' do
    it { should have_many(:goals) }

    it { should have_many(:comments) }

    it { should have_many(:commented_goals).through(:goals) }
  end

  describe 'class method' do
    describe "::find_by_credentials" do
      # before(:each) { user = create(:user) } <= BAD, SMELLS, use let instead
      let!(:user){ create(:user) }
      it "should return a user from username and password" do
        
        allow(user).to receive(:is_password?).and_return(true)
        expect(User.find_by_credentials(user.username, user.password)).to eq(user)
          
      end
    end
  end
  
end