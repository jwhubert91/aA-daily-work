# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  body       :text             not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Goal < ApplicationRecord

    validates :title, :body, presence: true
    
    belongs_to :author,
        class_name: :User

    has_many :comments,
        foreign_key: :goal_id

end
