require 'rails_helper'

RSpec.describe NotificationService do
  let(:valid_attributes) do
    {
      user_id: 1,
      title: 'Ticket 1',
      tags: ['tag 1', 'tag 2', 'tag 3']
    }
  end

  context 'send_highest_tag_count_to_webhook' do
    it 'posts data to webhook' do
      4.times do
        Tag.first_or_create_with_count!('tag 1')
        Tag.first_or_create_with_count!('tag 2')
      end

      Tag.first_or_create_with_count!('tag 3')

      body = {
        tags_with_max_count: [
          { name: 'tag 1', count: 4},
          { name: 'tag 2', count: 4}
        ]
      }.to_json

      headers = {content_type: 'application/json'}

      expect(RestClient).to receive(:post).with(NotificationService::WEBHOOK_URL, body, headers)

      NotificationService.send_highest_tag_count_to_webhook()
    end

  end
end
