class Api::TicketsController < ApplicationController
  def create
    process_api_request('Error when create ticket.') do
      ticket = TicketService.create_ticket!(params_for_create)

      render json: {
          created_ticket: {
            user_id: ticket.user_id,
            title: ticket.title,
            tags: ticket.tags.map(&:name)
          }
        }
    end
  end

  private

  def params_for_create
    params.permit([:user_id, :title, tags: []])
  end
end
