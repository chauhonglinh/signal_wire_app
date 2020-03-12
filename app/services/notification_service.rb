class NotificationService
  WEBHOOK_URL = 'https://webhook.site/cb50f200-e822-4d93-8683-c0ecfb2b6114'

  class << self
    def send_highest_tag_count_to_webhook()
      body = {
        tags_with_max_count: Tag.tags_with_max_count().map do |tag|
          {name: tag.name, count: tag.count}
        end
      }.to_json

      RestClient.post(WEBHOOK_URL, body, {content_type: 'application/json'})
    end
  end
end
