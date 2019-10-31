# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  comment_id :integer
#  artwork_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Like < ApplicationRecord

    belongs_to :likeable, polymorphic: true

    belongs_to :user_id,
        class_name: :User,
        primary_key: :id,
        foreign_key: :user_id

end
