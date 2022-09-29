require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'API Curriculums', type: :request do
  let(:user) { create(:user) }
  let(:curriculum) { create(:curriculum) }

  before do |response|
    sign_in user unless response.metadata[:skip_before]
  end

  # All Curriculums
  path '/api/curriculums' do
    get 'Returns a list of all curriculums' do
      tags 'Curriculums'
      produces 'application/json'

      response '200', 'Success' do
        schema type: :array, items: {
          properties: {
            id: { type: :integer },
            name: { type: :string }
          }
        }
        run_test!
      end

      response '401', 'Unauthorized', skip_before: true do
        run_test!
      end

      context 'when there are no curriculums created' do
        before do |example|
          submit_request(example.metadata)
        end

        it 'returns an empty array' do
          data = JSON.parse(response.body)
          expect(data.length).to eq(0)
        end
      end
    end
  end

  # A specific Curriculum
  path '/api/curriculums/{curriculum_id}' do
    get 'Curriculum by id' do
      tags 'Curriculums'
      produces 'application/json'
      parameter name: :curriculum_id, in: :path, type: :string

      response '200', 'Success' do
        schema type: :object, properties: {
          'id': { type: :integer },
          'name': { type: :string }
        }

        let(:curriculum_id) { create(:curriculum).id }
        run_test!
      end
    end
  end
end
