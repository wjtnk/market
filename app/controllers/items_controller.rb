class ItemsController < ApplicationController
  
  def index
    @items = Item.where(is_display: true).order(:display_order)
  end

end
