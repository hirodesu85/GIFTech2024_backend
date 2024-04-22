class Api::ItemsController < ApplicationController
  def index
    hairs = Hair.where(is_mine: true).select(:id, :name, :image_url, 'updated_at AS gained_at')
    tops = Top.where(is_mine: true).select(:id, :name, :image_url, 'updated_at AS gained_at')
    bottoms = Bottom.where(is_mine: true).select(:id, :name, :image_url, 'updated_at AS gained_at')
    shoes = Shoe.where(is_mine: true).select(:id, :name, :image_url, 'updated_at AS gained_at')

    render json: { hairs:, tops:, bottoms:, shoes: }
  end
end
