require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'API Resources', type: :request do
  let(:user) { create(:user) }
  let(:curriculum_id) { create(:curriculum).id }
  let(:learning_unit_id) { create(:learning_unit).id }
  let(:resource) { create(:resource, user:) }
  let(:resource_id) { create(:resource).id }
  let(:resource_comment) { create(:resource_comment, resource:, user:) }

  before do |response|
    sign_in user unless response.metadata[:skip_before]
  end

  # GET

  # All Resources

  path '/api/curriculums/{curriculum_id}/learning_units/{learning_unit_id}/resources' do
    get 'Returns a list of all comments' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :curriculum_id, in: :path, type: :string
      parameter name: :learning_unit_id, in: :path, type: :string

      response '200', 'Success' do
        schema type: :array, items: {
          properties: {
            id: { type: :integer },
            name: { type: :string },
            url: { type: :string },
            description: { type: :string }
          }
        }

        run_test!
      end

      response '401', 'Unauthorized', skip_before: true do
        run_test!
      end

      # context 'when there are no resources created' do
      #   before do |example|
      #     submit_request(example.metadata)
      #   end

      #   it 'returns an empty array' do
      #     data = JSON.parse(response.body)
      #     expect(data.length).to eq(0)
      #   end
      # end
    end
  end

  # All Comments
  path '/api/curriculums/{curriculum_id}/learning_units/{learning_unit_id}/resources/{resource_id}/comments' do
    get 'Returns a list of all comments' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :curriculum_id, in: :path, type: :string
      parameter name: :learning_unit_id, in: :path, type: :string
      parameter name: :resource_id, in: :path, type: :string

      response '200', 'Success' do
        schema type: :array, items: {
          properties: {
            id: { type: :integer },
            content: { type: :string }
          }
        }
        run_test!
      end

      response '401', 'Unauthorized', skip_before: true do
        run_test!
      end

      context 'when there are no comments created' do
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

  # POST

   # Create resorce
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
          url: { type: :string },
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
        let(:curriculum_id) { create(:curriculum).id }
        let(:learning_unit_id) { create(:learning_unit).id }
        let(:resource) { { name: 'test_resource', url: 'https://css-tricks.com/', description: 'Curso muy completo' } }
        run_test!
      end
    end
  end
  
  # Create comment

  path '/api/curriculums/{curriculum_id}/learning_units/{learning_unit_id}/resources/{resource_id}/comments' do
    post 'Create a new comment' do
      tags 'Resources'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :curriculum_id, in: :path, type: :string
      parameter name: :learning_unit_id, in: :path, type: :string
      parameter name: :resource_id, in: :path, type: :string
      parameter name: :resource_comment, in: :body, schema: {
        type: :object,
        properties: {
          content: { type: :string },
          user_id: { type: :integer },
          resource_id: { type: :integer },
        }
      }



      response '201', 'Created' do
        schema type: :object, properties: {
          content: { type: :string },
          user_id: { type: :integer },
          resource_id: { type: :integer },
        }
        let(:curriculum_id) { create(:curriculum).id }
        let(:learning_unit_id) { create(:learning_unit).id }
        let(:resource_id) { create(:resource).id }
        let(:resource_comment) { create(:resource_comment, resource:, user:) }
        run_test!
      end
    end
  end
end
