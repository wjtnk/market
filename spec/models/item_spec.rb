require 'rails_helper'

RSpec.describe Item, type: :model do

  it "商品を作成できること" do
    expect(FactoryBot.build(:item)).to be_valid
  end

  it "非表示商品を作成できること" do
    expect(FactoryBot.build(:item, :item_hidden)).to be_valid
  end

end
