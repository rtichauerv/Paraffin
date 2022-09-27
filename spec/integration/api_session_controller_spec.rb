require 'swagger_helper'
require 'rails_helper'

describe ApiSessionController do
  let(:user) { create(:user) }

  before do |response|
    sign_in user unless response.metadata[:skip_before]
  end

  path '/api/current_session' do
    get 'Retrieves current user data' do
      tags 'Session'
      operationId 'getSession'
      produces 'application/json'

      response '200', 'Success' do
        schema type: :object, properties: {
          'id': { type: :integer },
          'name': { type: :string },
          'email': { type: :string }
        }

        run_test!
      end

      response '401', 'Unauthorized', skip_before: true do
        schema type: :object, properties: {
          'error': { type: :string }
        }
        run_test!
      end
    end
  end
end
