require 'rails_helper'

RSpec.describe User, type: :model do

  it "ユーザーを作成できること" do
    expect(FactoryBot.build(:user)).to be_valid
  end

end
