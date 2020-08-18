class CartsController < ApplicationController
  before_action :authenticate_user!

  def add
    Cart.add_item(current_user.id, params[:item_id])
    #
    # puts "###########################"
    # puts Rails.cache.read(current_user.id)
    # puts "###########################"

    redirect_back(fallback_location: root_path)

  end

end
