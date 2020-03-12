class Ticket < ApplicationRecord
  has_many :tags_tickets
  has_many :tags, through: :tags_tickets

  validates :user_id, presence: true, numericality: true
  validates :title, presence: true
end
