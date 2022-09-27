require 'swagger_helper'
require 'rails_helper'

describe ApiLearningUnitsController do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  path '/api/curriculums/{curriculum_id}/learning_units' do
    get 'List of all learning units belonging to a curriculum' do
      tags 'Learning Units'
      operationId 'listLearningUnitsOfCurriculum'
      produces 'application/json'
      parameter name: :curriculum_id, in: :path, type: :string

      response '200', 'Success' do
        schema type: :array, items: {
          properties: {
            id: { type: :integer },
            name: { type: :string }
          }
        }
        let(:curriculum) { create(:curriculum) }
        let(:curriculum_id) { curriculum.id }
        run_test!

        context 'when there are no learning units' do
          before do |example|
            submit_request(example.metadata)
          end

          it 'returns an empty array' do
            data = JSON.parse(response.body)
            expect(data.length).to eq(0)
          end
        end

        context 'when there is one learning unit' do
          before do |example|
            create(
              :curriculum_affiliation,
              curriculum:,
              learning_unit: create(:learning_unit)
            )
            submit_request(example.metadata)
          end

          it 'returns an array with 1 element' do
            data = JSON.parse(response.body)
            expect(data.length).to eq(1)
          end
        end

        context 'when there are 2 or more curriculums' do
          before do |example|
            create(
              :curriculum_affiliation,
              curriculum:,
              learning_unit: create(:learning_unit)
            )
            create(
              :curriculum_affiliation,
              curriculum:,
              learning_unit: create(:learning_unit)
            )

            submit_request(example.metadata)
          end

          it 'returns an array with 2 elements' do
            data = JSON.parse(response.body)
            expect(data.length).to eq(2)
          end
        end
      end

      response '404', 'Curriculum Not Found' do
        schema type: :object, properties: {
          'code': { type: :integer },
          'message': { type: :string },
          'status': { type: :string }
        }
        let(:curriculum_id) { 'invalid' }
        run_test!
      end
    end
  end
end
