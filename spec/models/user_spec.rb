require 'rails_helper'

RSpec.describe User, type: :model do

  it "ユーザーを作成できること" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "Emailがないとユーザーを作成できないこと" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "Emailが重複していればユーザー作成できないこと" do
    FactoryBot.create(:user, email: "aaron@example.com")
    user = FactoryBot.build(:user, email: "aaron@example.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

end
