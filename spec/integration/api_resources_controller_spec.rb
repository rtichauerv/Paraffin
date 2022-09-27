require 'swagger_helper'
require 'rails_helper'

describe ApiResourcesController do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  path '/api/resources/{resource_id}' do
    get 'Retrieves a resource' do
      tags 'Resources'
      operationId 'getResource'
      produces 'application/json'
      parameter name: :resource_id, in: :path, type: :string

      response '200', 'Success' do
        schema type: :object, properties: {
          'resource': {
            type: :object, properties: {
              'id': { type: :integer },
              'name': { type: :string },
              'url': { type: :string, nullable: true }
            }
          },
          'average_evaluation': { type: :number, nullable: true }
        }

        let(:resource_id) { create(:resource).id }
        run_test!
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
