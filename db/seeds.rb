# 後でfind_or_create_by!に変更する

Bottom.transaction do
  Bottom.delete_all
  Bottom.create!(id: 1, name: "キュートなスカート(青)", image_url: "https://pub-2da3b55c4b23440c8f76b2b22e4db727.r2.dev/bottoms/toy_omocha_asobu_boy.webp", is_mine: true)
  Bottom.create!(id: 2, name: "サンプル2(後で消す)", image_url: "https://pub-2da3b55c4b23440c8f76b2b22e4db727.r2.dev/bottoms/d.webp", is_mine: false)
end

Hair.transaction do
  Hair.delete_all
  Hair.create!(id: 1, name: "キュートな髪型(ピンク)", image_url: "https://pub-2da3b55c4b23440c8f76b2b22e4db727.r2.dev/hairs/Icon_HP.webp", is_mine: true)
  Hair.create!(id: 2, name: "キュートな髪型(青)", image_url: "https://pub-2da3b55c4b23440c8f76b2b22e4db727.r2.dev/hairs/Icon_HB.webp", is_mine: false)
end

Shoe.transaction do
  Shoe.delete_all
  Shoe.create!(id: 1, name: "キュートなシューズ(黄)", image_url: "https://pub-2da3b55c4b23440c8f76b2b22e4db727.r2.dev/shoes/Icon_SY.webp", is_mine: true)
  Shoe.create!(id: 2, name: "キュートなシューズ(白)", image_url: "https://pub-2da3b55c4b23440c8f76b2b22e4db727.r2.dev/shoes/Icon_SW.webp", is_mine: false)
end

Top.transaction do
  Top.delete_all
  Top.create!(id: 1, name: "キュートなパーカー", image_url: "https://pub-2da3b55c4b23440c8f76b2b22e4db727.r2.dev/tops/Item_Pink.webp", is_mine: true)
  Top.create!(id: 2, name: "キュートなスカジャン", image_url: "https://pub-2da3b55c4b23440c8f76b2b22e4db727.r2.dev/tops/Item_Blue.webp", is_mine: false)
end

BeautyGirl.transaction do
  BeautyGirl.delete_all
  BeautyGirl.create!(id: 1,rank: 7, until_next_rank: 300, hairs_id: 1, shoes_id: 1, tops_id: 1, bottoms_id: 1)
end
