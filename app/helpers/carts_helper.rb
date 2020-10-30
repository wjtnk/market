module CartsHelper
  def get_item(item_id)
    Item.find(item_id)
  end
end
