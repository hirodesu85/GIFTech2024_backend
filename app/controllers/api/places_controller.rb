class Api::PlacesController < ApplicationController
  def suggest
    # クエリパラメータから値を取得
    category = params[:category]
    distance = params[:distance]
    lat = params[:lat]
    lng = params[:lng]

    # Todo: 取得APIの記述
    place = GooglePlacesService.fetch_unique_place(category, distance, lat, lng)

    response = {
      place_id: place[:place_id],
      latitude: place[:latitude],
      longitude: place[:longitude]
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