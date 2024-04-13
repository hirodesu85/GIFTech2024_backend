class Api::PlacesController < ApplicationController
  def suggest
    # クエリパラメータから値を取得
    category = params[:category]
    distance = params[:distance]
    lat = params[:lat]
    lng = params[:lng]

    # Todo: 取得APIの記述

    response = {
      place_id: "ChIJw76RQYuMGGARHeYoDcNpsZQ",
      latitude: 35.68765719762984,
      longitude: 139.7294224868288
    }

    render json: response
  end
  def arrive
    item = {
      id: 123456,
      category: "hair",
      name: "エメラルドグリーンのツインテール",
      image_url: "https://yukky-sandbox.dev/_astro/glaceon.DPjrUh7m_Z1iLFcK.webp",
    }
    response = {
      item:,
      rank: 8,
      until_next_rank: 180,
      get_rank_point: 100
    }
    render json: response
  end
end