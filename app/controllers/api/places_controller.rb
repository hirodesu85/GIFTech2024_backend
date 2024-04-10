module Api
  class PlacesController < ApplicationController
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
  end
end