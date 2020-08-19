module OrdersHelper

  # 商品の個数を算出する
  def get_item_count(items)
    count = 0
    items.values.each do |item|
      count += item
    end
    count
  end

end
