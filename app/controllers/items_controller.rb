class ItemsController < ApplicationController
  before_action :authenticate_user!,only:[:add, :remove]

  def index
    @items = Item.displayable
  end

end
