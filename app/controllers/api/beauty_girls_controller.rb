class Api::BeautyGirlsController < ApplicationController
  def put_on
    item1 = {
      "category": "hairs",
      "item_id": 123456
    }
    item2 = {
      "category": "shoes",
      "item_id": 123456
    }
    items = [item1, item2]
    render json: { items: }
  end
end