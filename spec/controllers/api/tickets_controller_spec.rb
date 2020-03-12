require 'rails_helper'

RSpec.describe Api::TicketsController, type: :controller do
  before :each do
    request.headers['CONTENT_TYPE'] = 'application/json'
  end

  let(:valid_params) do
    {
      user_id: 1,
      title: 'Ticket 1',
      tags: ['tag 1', 'tag 2', 'tag 3']
    }
  end

  context 'create' do
    it 'creates ticket successfully' do
      post :create, params: valid_params

      expect(response).to have_http_status(:ok)

      info = JSON.parse(response.body)
      ticket_info = info['created_ticket']
      expect(ticket_info.symbolize_keys).to eql(valid_params)
    end

    it 'sends back the error 422 if user_id is missing' do
      post :create, params: valid_params.reject {|k,v| k == :user_id}

      expect(response).to have_http_status(:unprocessable_entity)

      info = JSON.parse(response.body)
      expect(info['error']).to eql("param is missing or the value is empty: user_id")
    end

    it 'sends back the error 422 if user_id is not a number' do
      post :create, params: valid_params.merge({user_id: 'abc'})

      expect(response).to have_http_status(:unprocessable_entity)

      info = JSON.parse(response.body)
      expect(info['error']).to eql("Validation failed: User is not a number")
    end

    it 'sends back the error 422 if title is missing' do
      post :create, params: valid_params.reject {|k,v| k == :title}

      expect(response).to have_http_status(:unprocessable_entity)

      info = JSON.parse(response.body)
      expect(info['error']).to eql("param is missing or the value is empty: title")
    end

    it 'sends back the error 422 if there are more than 5 tags' do
      post :create, params: valid_params.merge({tags: ['Test tag'] * 6})

      expect(response).to have_http_status(:unprocessable_entity)

      info = JSON.parse(response.body)
      expect(info['error']).to eql("There cannot be more than 5 tags")
    end
  end
end
