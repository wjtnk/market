class ItemsController < ApplicationController
  before_action :authenticate_user!, only: %i[add remove]

  def index
    @items = Item.displayable
  end
end
