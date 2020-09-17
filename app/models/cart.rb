class Cart
  def initialize(user_id)
    @user_id = user_id
  end

  def add(item_id)
  end

  def remove(item_id)
  end

  def items
    Rails.cache.read(@user_id).presence || []
  end
end
