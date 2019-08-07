# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  # it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should validate_uniqueness_of(:username) }
  # it { should validate_uniqueness_of(:session_token) }
  
  subject(:ash) { 
    User.create(
    username: 'ashesashes',
    password: 'password'
    )
  }

  describe 'session_token' do
    it 'assigns a session token if there is none' do
      expect(FactoryBot.build(:user).session_token).not_to be_nil
    end
  end

  describe "is_password" do
    context "input is not the password" do
      it "returns false" do
        expect(FactoryBot.build(:user).is_password?('football')).to be_falsey
      end
    end

    context "input is the password" do
      it "returns true" do
        expect(FactoryBot.build(:user).is_password?('password')).to be_truthy
      end
    end
  end

  describe "find_by_credentials" do

    context "user exists and password is correct" do
      it "returns the user" do
        user =  FactoryBot.create(:user, username: 'jimmy')
        expect(User.find_by_credentials('jimmy', 'password')).to eq(user)
      end
    end

    context "user exists and password is incorrect" do
      it "returns nil" do
        user =  FactoryBot.create(:user, username: 'jimmy')
        expect(User.find_by_credentials('jimmy', 'football')).to be_nil
      end
    end

    context "user does not exist" do
      it "returns nil" do
        user =  FactoryBot.create(:user, username: 'jimmy')
        expect(User.find_by_credentials('horton', 'spangle')).to be_nil
      end
    end

  end


end
