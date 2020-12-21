require 'rails_helper'

RSpec.describe LettersController, type: :controller do
  describe 'POST #create' do
    context 'without authentication' do
      it 'should redirect' do
        post :create, params: {description: 'Ruby is awesome'}
        expect(response.status).to eq(302)
      end
    end
  end
end