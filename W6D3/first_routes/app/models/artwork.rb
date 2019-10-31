# == Schema Information
#
# Table name: artworks
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null

# Example syntax for scope uniqueness
# class Holiday < ApplicationRecord
#   validates :name, uniqueness: { scope: :year,
#     message: "should happen once per year" }
# end

class Artwork < ApplicationRecord
    validates :title, presence: true
    validates :image_url, presence: true
    validates :artist_id, presence: true
    validates :title, uniqueness: {scope: :artist_id, 
        message: "artist should have unique titles" }
    
    has_many :artwork_shares,
        class_name: :ArtworkShare,
        primary_key: :id,
        foreign_key: :artwork_id

    belongs_to :artist,
        class_name: :User,
        primary_key: :id,
        foreign_key: :artist_id

    has_many :shared_viewers,
        through: :artwork_shares,
        source: :viewer

    has_many :comments,
        class_name: :Comment,
        primary_key: :id,
        foreign_key: :artwork_id

    has_many :likes, as: :likeable

end
