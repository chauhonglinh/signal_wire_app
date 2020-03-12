class Tag < ApplicationRecord
  has_many :tags_tickets
  has_many :tickets, through: :tags_tickets

  class << self
    def first_or_create_with_count!(tag_name)
      # Find by case-insensitive name
      tag_name = tag_name.downcase
      tag = Tag.find_by(name: tag_name)
      if tag.nil?
        Tag.create!(name: tag_name, count: 1)
      else
        tag.update!(count: tag.count + 1)
        tag
      end
    end

    def tags_with_max_count()
      Tag.where(count: Tag.maximum(:count)).all
    end
  end
end
