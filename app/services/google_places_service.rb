require 'rest-client'
require 'json'

class GooglePlacesService
  BASE_URL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
  API_KEY = ENV["GOOGLE_PALACES_API_KEY"]

  def self.fetch_unique_place(category, distance, latitude, longitude)
    case distance
    when 'near'
      raw_results_json = search_places_json(category, 'near', latitude, longitude)
    when 'middle'
      raw_results_json_filter = search_places_json(category, 'near', latitude, longitude)
      raw_results_json_all = search_places_json(category, 'middle', latitude, longitude)
      # middleの全範囲-nearの全範囲=middleの範囲
      filter_place_ids = raw_results_json_filter.map { |result| result['place_id'] }
      raw_results_json = raw_results_json_all.reject { |result| filter_place_ids.include?(result['place_id']) }
    when 'far'
      raw_results_json_filter = search_places_json(category, 'middle', latitude, longitude)
      raw_results_json_all = search_places_json(category, 'far', latitude, longitude)
      # farの全範囲-middleの全範囲=farの範囲
      filter_place_ids = raw_results_json_filter.map { |result| result['place_id'] }
      raw_results_json = raw_results_json_all.reject { |result| filter_place_ids.include?(result['place_id']) }
    end
    
    # ランダムに1つ選択し、未訪問かどうかをチェック
    random_result_json = raw_results_json.sample
    place_id = random_result_json['place_id']
    unless place_id.nil? || VisitedPlace.exists?(place_id: place_id)
      return format_place(random_result_json)
    end

    raise "場所が見つかりません！！！"
  end

  private

  def self.search_places_json(category, distance, latitude, longitude)
    radius = map_distance_to_radius(distance)
    type = map_category_to_type(category)

    params = {
      key: API_KEY,
      location: "#{latitude},#{longitude}",
      radius: radius,
      type: type
    }

    response = RestClient.get(BASE_URL, { params: params })
    JSON.parse(response.body)["results"]
  end

  def self.format_place(result)
    {
      place_id: result['place_id'],
      latitude: result['geometry']['location']['lat'],
      longitude: result['geometry']['location']['lng'],
      name: result['name']
    }
  end

  def self.map_distance_to_radius(distance)
    case distance
    when 'near'
      1000
    when 'middle'
      10000
    when 'far'
      50000
    end
  end

  def self.map_category_to_type(category)
    case category
    when 'サウナ'
      'spa'
    when 'ごはん'
      'restaurant'
    when '散歩'
      nil
    end
  end
end
