require 'rails_helper'

RSpec.describe 'API Resources', type: :request do
  let(:user) { create(:user) }

  

  before do |_response|
    sign_in user
  end

  
  path '/api/curriculums/{curriculum_id}/learning_units/{learning_unit_id}/resources/create' do
    post 'Create a new resource' do
      tags 'Resources'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :curriculum_id, in: :path, type: :string
      parameter name: :learning_unit_id, in: :path, type: :string
      parameter name: :resource, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          url: { type: :string, default: 'https://example.com/' },
          description: { type: :string }
        }
      }

      response '201', 'Created' do
        schema type: :object, properties: {
          id: { type: :integer },
          name: { type: :string },
          url: { type: :string },
          description: { type: :string }
        }
        let(:curriculum) { create(:curriculum) }
        let(:learning_unit_id) { create(:learning_unit).id }
        let(:resource) { { name: 'test_resource', url: 'https://css-tricks.com/', description: 'Curso muy completo' } }
        run_test!
      end
    end
  end
end
