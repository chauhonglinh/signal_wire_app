require 'rails_helper'

RSpec.describe TicketService do
  let(:valid_attributes) do
    {
      user_id: 1,
      title: 'Ticket 1',
      tags: ['tag 1', 'tag 2', 'tag 3']
    }
  end

  context 'create_ticket!' do
    it 'creates ticket successfully' do
      ticket = TicketService.create_ticket!(valid_attributes)
      expect(ticket.user_id).to eql(1)
      expect(ticket.title).to eql('Ticket 1')
      expect(ticket.tags.map(&:name)).to eql(['tag 1', 'tag 2', 'tag 3'])
    end

    it 'failes with UnprocessableEntityException if there are more than 5 tags' do
      expect { TicketService.create_ticket!(valid_attributes.merge({tags: ['test tag'] * 6})) }.
      to raise_error(UnprocessableEntityException, 'There cannot be more than 5 tags')
    end
  end
end
