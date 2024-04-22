class Api::PlacesController < ApplicationController
  def suggest
    # クエリパラメータから値を取得
    category = params[:category]
    distance = params[:distance]
    lat = params[:lat]
    lng = params[:lng]

    place = GooglePlacesService.fetch_unique_place(category, distance, lat, lng)

    response = {
      place_id: place[:place_id],
      latitude: place[:latitude],
      longitude: place[:longitude],
      name: place[:name]
    }

    render json: response
  end

  def arrive
    place_id = params[:place_id]
    distance = params[:distance]

    rank_point = calc_rank_point_by distance

    raise NotImplementedError if place_id.nil?

    VisitedPlace.create! place_id: place_id

    now_girl = BeautyGirl.find_by(id: 1)
    updated_girl = provide_rank_point now_girl, rank_point

    present_item = select_random_item

    response = {
      item: present_item,
      rank: updated_girl.rank,
      until_next_rank: updated_girl.until_next_rank,
      get_rank_point: rank_point,
    }
    render json: response
  end

  private 

  # 距離から付与するランクポイントを計算する
  # @param distance [String] 距離(near, middle, far)
  # @return [Integer] ランクポイント
  def calc_rank_point_by(distance)
    case distance
    when "near"
      rank_point = 50
    when "middle"
      rank_point = 100
    when "far"
      rank_point = 200
    else
      raise NotImplementedError
    end
  end


  # 美少女にランクポイント(好感度)を与える
  # @param girl [BeautyGirl] 美少女
  # @param rank_point [Integer] ランクポイント
  # @return [BeautyGirl] ランクポイントを付与した後の美少女
  def provide_rank_point(girl, rank_point)
    now_rank = girl.rank
    required_rank_point = girl.until_next_rank

    if rank_point >= required_rank_point
      now_point = rank_point - required_rank_point
      until_next_rank = max_next_rank_point(now_rank + 1) - now_point
      girl.update!(rank: now_rank + 1, until_next_rank:)
      return girl
    end

    girl.update!(until_next_rank: required_rank_point - rank_point)
    girl
  end

  # ランクごとの次のランクへのランクアップに必要な最大ポイント
  # @param rank [Integer] ランク
  def max_next_rank_point(rank)
    case rank
    when 1
      100
    when 2
      200
    when 3
      300
    when 4
      400
    when 5
      500
    when 6
      600
    when 7
      700
    when 8
      800
    when 9
      900
    when 10
      1000
    else
      10000
    end
  end

  # ランダムにアイテムを選択する。性能はこの際気にしない。
  def select_random_item(complete_ids = [])
    nums = (0..3).to_a.difference(complete_ids)
    num = nums.empty? ? 5 : nums.sample
    model = case num
    when 0
      category = "hairs"
      hair = Hair.where(is_mine: false).sample

      return select_random_item(complete_ids.push(0)) if hair.nil?

      hair.update!(is_mine: true)
      hair
    when 1
      category = "shoes"
      shoe = Shoe.where(is_mine: false).sample

      return select_random_item(complete_ids.push(1)) if shoe.nil?

      shoe.update!(is_mine: true)
      shoe
    when 2
      category = "tops"
      top = Top.where(is_mine: false).sample

      return select_random_item(complete_ids.push(2)) if top.nil?

      top.update!(is_mine: true)
      top
    when 3
      category = "bottoms"
      bottom = Bottom.where(is_mine: false).sample

      return select_random_item(complete_ids.push(3)) if bottom.nil?

      bottom.update!(is_mine: true)
      bottom
    else
      # ここに辿り着かない程度にはアイテムを用意したい
      raise "すべてのアイテムを獲得しました"
    end
    {
      id: model.id,
      category:,
      name: model.name,
      image_url: model.image_url,
    }
  end
end
