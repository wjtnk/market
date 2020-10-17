require 'rails_helper'

RSpec.describe Cart, type: :model do

  it "カートを作成できること" do
    expect(FactoryBot.build(:cart)).to be_valid
  end

end
