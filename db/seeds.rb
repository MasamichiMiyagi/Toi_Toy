# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#管理者ログイン
#Admin.create!(
#  email: 'admin@admin',
#  password: 'adminadmin'
#)

Admin.create!(
  email: 'admin@test',
  password: 'admintest'
)

# 以下テストデータ
customers = Customer.create!(
  [
    {name: 'とり', email: 'sample-user1@test', password: 'testtest1', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename: "sample-user1.jpg")},
    {name: 'フェネック', email: 'sample-user2@test', password: 'testtest2', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename: "sample-user2.jpg")},
    {name: 'レッサーパンダ', email: 'sample-user3@test', password: 'testtest3', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename: "sample-user3.jpg")},
  ]
)

Game.create!(
  [
    {title: 'カタンの開拓者たち', body: '領地の開拓を競い合うゲームです', star: '4', player: '3~6人', play_time: '40分~', game_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename: "sample-post1.jpg"), customer_id: customers[0].id},
    {title: 'ルドー', body: 'ヨーロッパの伝統的なすごろく', star: '3', player: '3~6人', play_time: '20~40分', game_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename: "sample-post2.jpg"), customer_id: customers[1].id},
    {title: 'ダイヤモンドゲーム', body: '相手より先にゴールにたどり着け！', star: '3', player: '3~6人', play_time: '~20分', game_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename: "sample-post3.jpg"), customer_id: customers[2].id},
  ]
)
