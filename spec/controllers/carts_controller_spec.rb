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

end
