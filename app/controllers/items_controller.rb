class ItemsController < ApplicationController
  
  def index
    @items = Item.where(is_hidden: false).order(:display_order)
  end

end
