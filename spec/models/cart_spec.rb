require 'rails_helper'

RSpec.describe Cart, type: :model do

  describe "カートに商品を追加と削除" do

    let(:cart) {FactoryBot.create(:cart)}
    let(:item) {FactoryBot.create(:item)}
    let(:cart_item) {FactoryBot.create(:cart_item)}

    it "カートを作成できること" do
      expect(FactoryBot.build(:cart)).to be_valid
    end

    context "カートに商品を追加した時" do
      it "カートに商品を加えられること" do
        expect(cart.add_item(item.id)).to eq true
      end

      it "カートに商品を加えたとき、itemが新しいものだったらcart_itemsに「count: 1」として新規作成されること" do
        expect{cart.add_item(item.id)}.to change{ cart.cart_items.count }.from(0).to(1)
      end

      it "カートに商品を加えたとき、itemに同じものがあればcart_itemsに商品を追加してもcart_itemsの総数は更新されないこと" do
        cart.add_item(item.id) #1つ目の商品追加
        #2つ目の商品追加
        expect{ cart.add_item(item.id) }.to change{ cart.cart_items.count }.by(0)
      end

      it "カートに商品を加えたとき、itemに同じものがあればcart_itemsに「count: 2」として更新されること" do
        cart.add_item(item.id) #1つ目の商品追加
        #2つ目の商品追加
        expect{ cart.add_item(item.id) }.to change{ cart.cart_items.find_by(item: item.id).count }.from(1).to(2)
      end
    end

    context "カートから商品を削除した時" do
      it "カートから商品を削除できること" do
        cart_item.cart.remove_item(cart_item.item_id)
        expect{cart_item.reload.count}.to raise_error ActiveRecord::RecordNotFound
      end

      it "カートに同じitemの商品が2個以上ある時,削除したらcountが1減ること" do
        cart_item = FactoryBot.create(:cart_item, count:2)
        expect{ cart_item.cart.remove_item(cart_item.item_id) }.to change{ cart_item.reload.count }.from(2).to(1)
      end
    end

  end

  describe "カートに入っている商品の金額系" do

    let(:item_1) { FactoryBot.create(:item, price:1000) }
    let(:item_2) { FactoryBot.create(:item, price:1500) }
    let(:cart_item) { FactoryBot.create(:cart_item, item: item_1, count:2) }
    let!(:cart_item_1) { FactoryBot.create(:cart_item, cart: cart_item.cart, item: item_2, count:3) }

    it "カートに入っている商品(購入する商品)の合計個数を返すこと" do
      expect( cart_item.cart.item_count ).to eq 5
    end

    it "カートに入っている商品合計金額を返すこと" do
      # 1000 * 2 + 1500 * 3 = 6500
      expect( cart_item.cart.item_total_price ).to eq 6500
    end

    it "カートに入っている送料(5商品ごとに600円追加)を返すこと" do
      expect( cart_item.cart.delivery_fee ).to eq 600
    end

  end

end
