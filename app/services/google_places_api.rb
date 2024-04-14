require 'rest-client'
require 'json'

class GooglePlacesApi
  BASE_URL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
  API_KEY = "hogefugapiyo"

  def self.find_place(category, distance, lat, lng)
    radius = convert_distance_to_radius(distance)
    type = map_category_to_type(category)

    response = RestClient.get BASE_URL, {
      params: {
        key: API_KEY,
        location: "#{lat},#{lng}",
        radius: radius,
        type: type
      }
    }
    data = JSON.parse(response.body)

    if data["results"].any?
      result = data["results"].first
      {
        place_id: result["place_id"],
        latitude: result["geometry"]["location"]["lat"],
        longitude: result["geometry"]["location"]["lng"]
      }
    else
      nil
    end
  end

  private

  def self.convert_distance_to_radius(distance)
    case distance
    when 'near'
      500
    when 'middle'
      1500
    when 'far'
      3000
    end
  end

  def self.map_category_to_type(category)
    case category
    when 'サウナ'
      'サウナ'
    when '温泉'
      '温泉'
    when '散歩'
      nil
    end
  end
end