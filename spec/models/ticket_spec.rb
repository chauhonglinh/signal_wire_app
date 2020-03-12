require 'rails_helper'

RSpec.describe Ticket, type: :model do
  context 'associations' do
    it { should have_many(:tags_tickets) }
    it { should have_many(:tags) }
  end

  context 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_numericality_of(:user_id) }
    it { should validate_presence_of(:title) }
  end
end
