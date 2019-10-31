# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#   create_table "artwork_shares", force: :cascade do |t|
#     t.integer "artwork_id", null: false
#     t.integer "viewer_id", null: false
#     t.datetime "created_at", precision: 6, null: false
#     t.datetime "updated_at", precision: 6, null: false
#     t.index ["artwork_id"], name: "index_artwork_shares_on_artwork_id"
#     t.index ["viewer_id"], name: "index_artwork_shares_on_viewer_id"
#   end

#   create_table "artworks", force: :cascade do |t|
#     t.string "title", null: false
#     t.string "image_url", null: false
#     t.integer "artist_id", null: false
#     t.datetime "created_at", precision: 6, null: false
#     t.datetime "updated_at", precision: 6, null: false
#     t.index ["artist_id"], name: "index_artworks_on_artist_id"
#   end

#   create_table "users", force: :cascade do |t|
#     t.datetime "created_at", precision: 6, null: false
#     t.datetime "updated_at", precision: 6, null: false
#     t.string "username", null: false

# users data
ActiveRecord::Base.transaction do

User.destroy_all
Artwork.destroy_all
ArtworkShare.destroy_all
Comment.destroy_all

    user1 = User.create!(username: 'James')
    user2 = User.create!(username: 'David')
    user3 = User.create!(username: 'Zeus')

    artwork1 = Artwork.create!(title: 'Mona Lisa', image_url: 'www.louvre.com', artist_id: user3.id)
    artwork2 = Artwork.create!(title: 'Starry Night', image_url: 'www.gugenheim.com', artist_id: user2.id)
    artwork3 = Artwork.create!(title: 'Statue of Liberty', image_url: 'www.metropolitan.com', artist_id: user1.id)

    artworkshare1 = ArtworkShare.create!(artwork_id: artwork2.id, viewer_id: user2.id)
    artworkshare2 = ArtworkShare.create!(artwork_id: artwork1.id, viewer_id: user3.id)
    artworkshare3 = ArtworkShare.create!(artwork_id: artwork3.id, viewer_id: user1.id)

    comment1 = Comment.create!(user_id: user1.id, artwork_id: artwork1.id, body: 'hmm.. very interesting')
    comment2 = Comment.create!(user_id: user2.id, artwork_id: artwork2.id, body: 'quite perculiar')
    comment3 = Comment.create!(user_id: user3.id, artwork_id: artwork3.id, body: 'fascinating!')

    like1 = Like.create!(user_id: user1.id, artwork_id: artwork2.id)

end