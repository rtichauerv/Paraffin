require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'API User', type: :request do
  let(:user) { create(:user) }
  # let(:curriculum_id) { create(:curriculum).id }
  # let(:learning_unit_id) { create(:learning_unit).id }
  # let(:resource) { create(:resource, user:) }
  # let(:resource_id) { create(:resource).id }
  # let(:resource_comment) { create(:resource_comment, resource:, user:) }

  before do |response|
    sign_in user unless response.metadata[:skip_before]
  end

  path '/api/user' do
    get 'Returns the user info' do
      tags 'User'
      produces 'application/json'

      response '200', 'Success' do
        schema type: :objet, items: {
          properties: {
            id: { type: :integer },
            name: { type: :string },
            email: { type: :string }
          }
        }
        run_test!
      end

      response '401', 'Unauthorized', skip_before: true do
        schema type: :object, items: {
          properties: {
            error: { type: :string }
          }
        }
        run_test!
      end
    end
  end
end
