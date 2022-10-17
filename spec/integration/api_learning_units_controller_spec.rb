require 'swagger_helper'
require 'rails_helper'

describe ApiLearningUnitsController do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  path '/api/learning_units/{learning_unit_id}' do
    get 'Retrieves a Learning unit' do
      tags 'Learning Units'
      operationId 'getLearningUnit'
      produces 'application/json'
      parameter name: :learning_unit_id, in: :path, type: :string

      response '200', 'Success' do
        schema type: :object, properties: {
          'id': { type: :integer },
          'name': { type: :string },
          'description': { type: :string, nullable: true }
        }

        let(:learning_unit_id) { create(:learning_unit).id }
        run_test!
      end

      response '404', 'Learning Unit Not Found' do
        schema type: :object, properties: {
          'code': { type: :integer },
          'message': { type: :string },
          'status': { type: :string }
        }
        let(:learning_unit_id) { 'invalid' }
        run_test!
      end
    end
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
            name: { type: :string },
            description: { type: :string, nullable: true }
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

  path '/api/learning_units/{learning_unit_id}/is_completed' do
    get 'Completion status of a learning unit for a user' do
      tags 'Learning Units'
      get 'List of all learning units belonging to a curriculum' do
        tags 'Learning Units'
        operationId 'isLearningUnitCompleted'
        produces 'application/json'
        parameter name: :learning_unit_id, in: :path, type: :string

        response '200', 'Success' do
          schema type: :object, properties: {
            'completed': { type: :boolean }
          }
          let(:learning_unit_id) { create(:learning_unit).id }

          context 'when the learning unit is not completed' do
            before do |example|
              submit_request(example.metadata)
            end

            it 'returns true' do
              data = JSON.parse(response.body)
              expect(data['completed']).to be false
            end
          end

          context 'when the learning unit is completed' do
            before do |example|
              create(:completed_learning_unit, learning_unit_id:, user:)
              submit_request(example.metadata)
            end

            it 'returns true' do
              data = JSON.parse(response.body)
              expect(data['completed']).to be true
            end
          end
        end
      end
    end
  end
end
