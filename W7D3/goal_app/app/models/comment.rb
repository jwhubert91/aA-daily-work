# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  author_id  :integer          not null
#  goal_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord

    validates :body, presence: true

    belongs_to :author,
        class_name: :User

    belongs_to :goal

end
