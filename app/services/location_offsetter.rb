# 現在地から離れた距離の緯度・経度をランダムに算出するクラス
class LocationOffsetter
    # 地球の半径（キロメートル）
    EARTH_RADIUS_KM = 6371.0
  
    # 緯度（latitude）、経度（longitude）からランダムに位置をずらすメソッド
    def self.random_offset(latitude, longitude, distanceType)

      if distanceType == 'middle' then
        # ランダムな距離（2km〜10km）を生成
        distance = rand(2.0..10.0)
      elsif distanceType == 'far' then
        # ランダムな距離（250km～800km）を生成
        distance = rand(250.0..800.0)
      end

      puts "距離は#{distance}です"
      # 角度（0°〜360°）を生成
      angle = rand(0.0..360.0)
  
      # 角度をラジアンに変換
      angle_rad = angle * Math::PI / 180.0
  
      # 新しい緯度を計算
      new_latitude = latitude + (distance / EARTH_RADIUS_KM) * (Math.cos(angle_rad) * 180.0 / Math::PI)
      # 新しい経度を計算
      new_longitude = longitude + (distance / EARTH_RADIUS_KM) * (Math.sin(angle_rad) * 180.0 / Math::PI) / Math.cos(latitude * Math::PI / 180.0)
  
      # 新しい緯度と経度を返す
      puts "場所：#{new_latitude},#{new_longitude}"
      [new_latitude, new_longitude]
    end
end
  