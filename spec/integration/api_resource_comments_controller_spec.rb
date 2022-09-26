require 'swagger_helper'

describe ApiResourceCommentsController do
  let(:user) { create(:user) }
  let(:resource) { create(:resource, user:) }
  let(:resource_id) { resource.id }
  let(:resource_comment) { create(:resource_comment, resource:, user:) }

  before do
    sign_in user
  end

  path '/api/resources/{resource_id}/resource_comments' do
    get 'Retrieves a list of resource comments' do
      tags 'Resource Comments'
      operationId 'getResourceComments'
      produces 'application/json'
      parameter name: :resource_id, in: :path, type: :string

      response '200', 'Success' do
        schema type: :array,
               items: {
                 properties: {
                   id: { type: :integer },
                   user_id: { type: :integer },
                   resource_id: { type: :integer },
                   content: { type: :string }
                 }
               }
        run_test!

        context 'when resource have a comment' do
          before do |example|
            resource_comment.save
            submit_request(example.metadata)
          end

          it 'returns one element' do
            data = JSON.parse(response.body)
            expect(data.length).to eq(1)
          end
        end

        context 'when resource have no comments' do
          before do |example|
            submit_request(example.metadata)
          end

          it 'returns no elements' do
            data = JSON.parse(response.body)
            expect(data.length).to eq(0)
          end
        end
      end

      response '404', 'Resource Not Found' do
        schema type: :object, properties: {
          'code': { type: :integer },
          'message': { type: :string },
          'status': { type: :string }
        }
        let(:resource_id) { 'invalid' }
        run_test!
      end
    end
  end
end
