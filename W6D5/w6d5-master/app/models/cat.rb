# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string
#  name        :string           not null
#  sex         :string           not null
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#


class Cat < ApplicationRecord
    # include ActionView::Helpers::DateHelper

    validate :valid_color?
    validate :valid_sex?

    CAT_COLORS = [ 'brown', 'spotted', 'black', 'grey' ]

    def age
        bday = self.birth_date
        today = Time.now.to_date
        years_between_dates(bday, today)
    end

    def cat_colors
        CAT_COLORS
    end

    private
    def valid_color?
        unless cat_colors.include?(color)
            errors[:color] << "must be valid color"
        end
    end

    def valid_sex?
        unless sex == "M" || sex == "F"
            errors[:sex] << "must be M or F"
        end
    end

    def years_between_dates(date_from, date_to)
        ((date_to.to_time - date_from.to_time) / 1.year.seconds).floor
    end

end

# http://ruby-doc.org/stdlib-2.1.2/libdoc/date/rdoc/Date.html

# https://open.appacademy.io/learn/swe-in-person-nyc/sql/custom-validations