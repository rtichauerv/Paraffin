require 'swagger_helper'
require 'rails_helper'

describe ApiResourceCommentsController do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'Resources Comments API' do
    path'/api/resources/{resource_id}/resource_comments' do
      post 'Creates a new comment' do
        tags 'Resource comment'
        produces 'application/json'
        operationId 'createResourceComment'
        parameter name: :resource_id, in: :path, type: :string
        consumes 'application/json'
        parameter name: :content, in: :body, schema: {
          type: :object,
          properties: {
            content: { type: :string }
          },
          required: ['content' ]
        }
        
        response '200', 'Success' do
          schema type: :object,
            properties: {
              id: { type: :integer },
              content: { type: :string },
              resourceId: { type: :integer },
            }
          run_test!
        end
      end
    end
  end
end