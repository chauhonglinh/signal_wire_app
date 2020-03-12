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
    {
      user_id: params.require(:user_id),
      title: params.require(:title),
      tags: params[:tags]
    }
  end
end
