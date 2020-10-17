require 'rails_helper'

RSpec.describe Cart, type: :model do

  it "カートを作成できること" do
    expect(FactoryBot.build(:cart)).to be_valid
  end

  it "カートに商品を加えられること" do
    cart = FactoryBot.create(:cart)
    item = FactoryBot.create(:item)
    expect(cart.add_item(item.id)).to eq true
  end

end
