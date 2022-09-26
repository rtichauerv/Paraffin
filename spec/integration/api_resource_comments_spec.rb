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
        consumes 'application/json'
        parameter name: :resource_id, in: :path, type: :string
        parameter name: :jsonBody, in: :body, schema: {
          type: :object,
          properties: {
            content: {type: :string}
          },
          required: ['content']
        }
        produces 'application/json'
        operationId 'createResourceComment'
        
        response '201', 'Success' do
          schema type: :object,
            properties: {
              id: { type: :integer },
              content: { type: :string },
              resource_id: { type: :integer },
            }
          let(:resource_id){create(:resource).id}
          let(:jsonBody){{'content': 'test'}}
          run_test!
        end

        response 400, "Invalid parameters" do
          schema type: :object, properties: {
            'code': { type: :integer },
            'message': { type: :string },
            'status': { type: :string }
          }
        
          context "content must exist in json body" do
            let(:resource_id){create(:resource).id}
            let(:jsonBody) {{ 'asd': 'test' }}
            run_test!
          end

          context "content can not be null" do
            let(:resource_id){create(:resource).id}
            let(:jsonBody) {{ 'content': '' }}
            run_test!
          end
        end

        response 404, "Resource does not exist" do
          schema type: :object, properties: {
            'code': { type: :integer },
            'message': { type: :string },
            'status': { type: :string }
          }
          context "resource does not exist" do
            let(:resource_id) { 'invalid' }
            let(:jsonBody){{'content': 'test'}}
            run_test!
          end
        end
        
      end
    end
  end
end