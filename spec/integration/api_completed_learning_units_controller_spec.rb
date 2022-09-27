require 'swagger_helper'
require 'rails_helper'

describe ApiCompletedLearningUnitsController do
  let(:user) { create(:user) }
  let(:curriculum) { curriculum_with_learning_units(learning_units_count: 4) }
  let(:curriculum_id) { curriculum.id }

  before do
    sign_in user
  end

  path '/api/curriculums/{curriculum_id}/completed_learning_units' do
    get 'List of all the learning units that belong to this curriculum, '\
    'completed by the user' do
      tags 'Learning Units'
      operationId 'listCompletedLearningUnitsOfCurriculumCompletedByUser'
      produces 'application/json'
      parameter name: :curriculum_id, in: :path, type: :string

      response '200', 'Success' do
        schema type: :array, items: {
          properties: {
            id: { type: :integer },
            learning_unit_id: { type: :integer }
          }
        }
        run_test!

        context 'when there are no completed learning units' do
          before do |example|
            submit_request(example.metadata)
          end

          it 'returns an empty array' do
            data = JSON.parse(response.body)
            expect(data.length).to eq(0)
          end
        end

        context 'when there is one completed learning unit' do
          before do |example|
            create(
              :completed_learning_unit,
              learning_unit: curriculum.learning_units.first,
              user:
            )
            submit_request(example.metadata)
          end

          it 'returns an array with 1 element' do
            data = JSON.parse(response.body)
            expect(data.length).to eq(1)
          end
        end

        context 'when there are 2 completed learning units' do
          before do |example|
            create(
              :completed_learning_unit,
              learning_unit: curriculum.learning_units.first,
              user:
            )
            create(
              :completed_learning_unit,
              learning_unit: curriculum.learning_units.last,
              user:
            )
            submit_request(example.metadata)
          end

          it 'returns an array with 2 elements' do
            data = JSON.parse(response.body)
            expect(data.length).to eq(2)
          end
        end
      end

      response 404, 'Curriculum Not Found' do
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
