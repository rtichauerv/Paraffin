require 'swagger_helper'

describe 'Curriculums API' do
  path '/api/curriculums' do
    get 'All curriculums' do
      tags 'Curriculums'
      produces 'application/json'

      response '200', 'Success' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string }
                 }
               }
        run_test!
      end
    end
  end
end
