class Task < ApplicationRecord
    before_validation :set_titleless
    validates :title, presence: true
    validates :title, length: { maximum: 30}
    validate :validate_title_not_comma
    belongs_to :user
    has_one_attached :image

    def self.csv_attributes
        ["id", "title", "content", "user_id", "created_at", "time"]
    end

    def self.generate_csv
        CSV.generate(headers: true) do |csv|
            csv << csv_attributes
            all.each do |task|
                csv << csv_attributes.map{|attr| task.send(attr)} 
            end
        end
    end

    def self.import(file)
        CSV.foreach(file.path, headers: true) do |row|
            task = new
            task.attributes = row.to_hash.slice(*csv_attributes)
            task.save!
        end
    end

    private

    def validate_title_not_comma
        errors.add(:title, "にカンマを含めることはできません") if title&.include?('、')
    end

    def set_titleless
        self.title = "タイトル無し" if title.blank?
    end

end
