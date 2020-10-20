class Song < ApplicationRecord
    validates :title, presence: true, uniqueness: true 
    validates :release_year, presence: true, if: :released?
    validate :date_not_possible
    validates :artist_name, presence: true
    validate :no_repeat_titles
    validates :released, inclusion: { in: [true, false] }

    def no_repeat_titles
        if Song.any? { |s| s.title == title && s.artist_name == artist_name && s.release_year == release_year}
            errors.add(:title, "can't add duplicate songs")
        end
    end

    def date_not_possible 
        if release_year.present? && release_year > Date.today.year
            errors.add(:release_year, "invalid release year")
        end
    end
end
