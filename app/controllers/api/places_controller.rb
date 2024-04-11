class Api::PlacesController < ApplicationController
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
