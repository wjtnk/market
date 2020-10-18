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

  it "カートに商品を加えたとき、itemが新しいものだったらcart_itemsに「count: 1」として新規作成されること" do
    cart = FactoryBot.create(:cart)
    item = FactoryBot.create(:item)
    expect{cart.add_item(item.id)}.to change{ cart.cart_items.count }.by(1)
  end

  it "カートに商品を加えたとき、itemに同じものがあればcart_itemsに商品を追加してもcart_itemsの総数は更新されないこと" do
    cart = FactoryBot.create(:cart)
    item = FactoryBot.create(:item)
    cart.add_item(item.id) #1つ目の商品追加
    cart.add_item(item.id) #2つ目の商品追加
    expect(cart.cart_items.count).to eq 1
  end

  it "カートに商品を加えたとき、itemに同じものがあればcart_itemsに「count: 2」として更新されること" do
    cart = FactoryBot.create(:cart)
    item = FactoryBot.create(:item)
    cart.add_item(item.id) #1つ目の商品追加
    cart.add_item(item.id) #2つ目の商品追加
    expect( cart.cart_items.find_by(item: item.id).count ).to eq 2
  end

end
