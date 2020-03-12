class TicketService
  class << self
    def create_ticket!(attributes)
      user_id = attributes[:user_id]
      title = attributes[:title]
      tag_names = attributes[:tags] || []

      validate_tags(tag_names)

      ticket = build_ticket_and_tags!(user_id: user_id, title: title, tag_names: tag_names)

      NotificationService.send_highest_tag_count_to_webhook()

      ticket
    rescue => exc
      Rails.logger.error("Error: #{exc.message}\n#{exc.backtrace.join("\n")}")
      raise  UnprocessableEntityException, exc.message
    end

    private
    def validate_tags(tags)
      raise  UnprocessableEntityException, 'There cannot be more than 5 tags' if tags.size > 5
      true
    end

    def build_ticket_and_tags!(user_id:, title:, tag_names:)
      tags = tag_names.map {|tag_name| Tag.first_or_create_with_count!(tag_name)}
      Ticket.create!({user_id: user_id, title: title, tags: tags})
    end
  end
end
