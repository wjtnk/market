require 'rails_helper'

RSpec.describe CartsController, type: :controller do

  describe "#index" do
    it "正常にレスポンスを返すこと " do
      user = FactoryBot.create(:user)
      sign_in user
      get :index
      expect(response).to be_success
    end
  end

  describe "#add_item" do
    it "商品を追加できること" do
      item = FactoryBot.create(:item)
      user = FactoryBot.create(:user)
      sign_in user
      post :add_item, params: { item_id: item.id }
      expect(response).to redirect_to carts_path
    end
  end

  # describe "#remove_item" do
  #   it "商品を追加できること" do
  #     item = FactoryBot.create(:item)
  #     user = FactoryBot.create(:user)
  #     sign_in user
  #     post :add_item, params: { item_id: item.id }
  #     expect(response).to redirect_to carts_path
  #   end
  # end

end
