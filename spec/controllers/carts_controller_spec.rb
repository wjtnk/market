require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe '#index' do
    context '認証済みのユーザーとして' do
      it '正常にレスポンスを返すこと ' do
        user = FactoryBot.create(:user)
        sign_in user
        get :index
        expect(response).to be_success
      end
    end

    context 'ゲストユーザーとして' do
      it 'サインイン画面にリダイレクトすること' do
        get :index
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#add_item' do
    context '認証済みのユーザーとして' do
      it '商品を追加できること' do
        item = FactoryBot.create(:item)
        user = FactoryBot.create(:user)
        sign_in user
        post :add_item, params: { item_id: item.id }
        expect(response).to redirect_to carts_path
      end

      it '商品を追加するとcart_itemが1つ増えること' do
        user = FactoryBot.create(:user)
        FactoryBot.create(:cart_item, cart: user.cart)
        item = FactoryBot.create(:item)

        sign_in user
        expect { post :add_item, params: { item_id: item.id } }.to change { user.cart.cart_items.count }.from(1).to(2)
      end
    end

    context 'ゲストユーザーとして' do
      it 'サインイン画面にリダイレクトすること' do
        item = FactoryBot.create(:item)
        post :add_item, params: { item_id: item.id }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#remove_item' do
    context '認証済みのユーザーとして' do
      it '商品を削除できること' do
        user = FactoryBot.create(:user)
        cart_item = FactoryBot.create(:cart_item, cart: user.cart)
        sign_in user
        delete :remove_item, params: { item_id: cart_item.item_id }
        expect(response).to redirect_to root_path
      end

      it '商品を削除するとcart_itemが1つ減ること' do
        user = FactoryBot.create(:user)
        FactoryBot.create(:cart_item, cart: user.cart)
        item = FactoryBot.create(:item)
        FactoryBot.create(:cart_item, cart: user.cart, item: item)

        sign_in user
        expect { delete :remove_item, params: { item_id: item.id } }.to change { user.cart.cart_items.count }.from(2).to(1)
      end
    end

    context 'ゲストユーザーとして' do
      it 'サインイン画面にリダイレクトすること' do
        cart_item = FactoryBot.create(:cart_item)
        delete :remove_item, params: { item_id: cart_item.item_id }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end
