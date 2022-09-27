require 'swagger_helper'
require 'rails_helper'

describe ApiCurriculumsController do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  path '/api/curriculums' do
    get 'List of all curriculums' do
      tags 'Curriculums'
      operationId 'listCurriculums'
      produces 'application/json'

      response '200', 'Success' do
        schema type: :array, items: {
          properties: {
            id: { type: :integer },
            name: { type: :string }
          }
        }
        run_test!

        context 'when there are no curriculums' do
          before do |example|
            submit_request(example.metadata)
          end

          it 'returns an empty array' do
            data = JSON.parse(response.body)
            expect(data.length).to eq(0)
          end
        end

        context 'when there is one curriculum' do
          before do |example|
            create(:curriculum)
            submit_request(example.metadata)
          end

          it 'returns an array with 1 element' do
            data = JSON.parse(response.body)
            expect(data.length).to eq(1)
          end
        end

        context 'when there are 2 or more curriculums' do
          before do |example|
            create(:curriculum)
            create(:curriculum)
            submit_request(example.metadata)
          end

          it 'returns an array with 2 elements' do
            data = JSON.parse(response.body)
            expect(data.length).to eq(2)
          end
        end
      end
    end
  end
end
