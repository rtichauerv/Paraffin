require 'swagger_helper'
require 'rails_helper'

describe ApiResourceEvaluationsController do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  path '/api/resources/{resource_id}/resource_evaluation' do
    put 'Creates or modifies the evaluation of a resource' do
      tags 'ResourceEvaluations'
      consumes 'application/json'
      parameter name: :resource_id, in: :path, type: :string
      parameter name: :evaluation, in: :body, schema: {
        type: :object,
        properties: {
          evaluation: { type: :integer }
        },
        required: ['evaluation']
      }
      produces 'application/json'

      response '200', 'Success' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 evaluation: { type: :integer },
                 resource_id: { type: :integer },
                 user_id: { type: :integer }
               }
        let(:resource_id) { create(:resource).id }
        let(:evaluation) { { evaluation: 5 } }
        run_test!
      end

      response 404, 'Resource does not exist' do
        schema type: :object, properties: {
          'code': { type: :integer },
          'message': { type: :string },
          'status': { type: :string }
        }
        context 'when resource does not exist' do
          let(:resource_id) { 'invalid' }
          let(:evaluation) { { evaluation: 2 } }

          run_test!
        end
      end
    end
  end
end
