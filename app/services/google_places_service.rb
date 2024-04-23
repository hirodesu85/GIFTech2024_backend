require 'rest-client'
require 'json'

class GooglePlacesService
  BASE_URL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
  API_KEY = ENV["GOOGLE_PLACES_API_KEY"]

  def self.fetch_unique_place(category, distance, latitude, longitude)
    raw_results_json = []
    loop do
      case distance
      when 'near'
        raw_results_json = search_places_json(category, latitude, longitude, 1000)
      when 'middle'
        selected_location = LocationOffsetter.random_offset(latitude.to_f, longitude.to_f, "middle")
        raw_results_json = search_places_json(category, selected_location[0], selected_location[1], 1000)
      when 'far'
        selected_location = LocationOffsetter.random_offset(latitude.to_f, longitude.to_f, "far")
        # 見つからなすぎるので半径1kmではなく10kmで検索。
        raw_results_json = search_places_json(category, selected_location[0], selected_location[1], 10000)
      end

      # JSONが空でない場合はループを抜ける（farの時に田舎が指定されて見つからない事象が多発するため記述）
      break unless raw_results_json.empty?
    end

    loop do
      # ランダムに1つ選択し、未訪問かどうかをチェック
      random_result_json = raw_results_json.sample
      place_id = random_result_json['place_id']
      unless place_id.nil? || VisitedPlace.exists?(place_id: place_id)
        return format_place(random_result_json)
      end

      # 訪問済みのが選ばれたら再選択させる（再選択の際に訪問済みのplace_idは消しておく）
      raw_results_json.delete_if { |item| item['place_id'] == place_id }

      # 配列が空になった場合、ループを抜ける
      break if raw_results_json.empty?
    end

    raise NotFound
  end

  private

  def self.search_places_json(category, latitude, longitude, radius)
    # typeがspaだとジムや美容院にも引っかかったのでサウナはキーワードで対処してます、、、
    if category == "サウナ" then
      params = {
        key: API_KEY,
        location: "#{latitude},#{longitude}",
        radius: radius,
        keyword: "サウナ"
      }
    else
      type = map_category_to_type(category)

      params = {
        key: API_KEY,
        location: "#{latitude},#{longitude}",
        radius: radius,
        type: type
      }
    end

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
