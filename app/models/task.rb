class Task < ApplicationRecord
    before_validation :set_titleless
    validates :title, presence: true
    validates :title, length: { maximum: 30}
    validate :validate_title_not_comma
    belongs_to :user

    private

    def validate_title_not_comma
        errors.add(:title, "にカンマを含めることはできません") if title&.include?('、')
    end

    def set_titleless
        self.title = "タイトル無し" if title.blank?
    end

end
