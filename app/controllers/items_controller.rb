class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = Item.displayable
  end
end
