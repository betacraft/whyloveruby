require 'rails_helper'

RSpec.describe LettersController, type: :controller do
  describe 'POST #create' do
    context 'without authentication' do
      it 'should redirect' do
        post :create, params: {description: 'Ruby is awesome'}
        expect(response.status).to eq(302)
      end

      it 'should redirect to login page' do
        post :create, params: {description: 'Ruby is awesome'}
        expect(response).to redirect_to  %r(\Ahttp://test.host/users/sign_in)
      end
    end
  end

  describe 'GET #show' do
    context 'without authentication' do
      it 'return http success' do
        letter = Letter.create(description: "Ruby is awesome")
        get :show, params: {id: letter.id}
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'GET #edit' do
    context 'without authentication' do
      it 'should redirect to login page' do
        letter = Letter.create(description: "Ruby is awesome")
        get :edit, params: {id: letter.id}
        expect(response).to redirect_to  %r(\Ahttp://test.host/users/sign_in)
      end
    end
  end

  describe 'GET #update' do
    context 'without authentication' do
      it 'should redirect to login page' do
        letter = Letter.create(description: "Ruby is awesome")
        post :update, params: {id: letter.id}
        expect(response).to redirect_to  %r(\Ahttp://test.host/users/sign_in)
      end
    end
  end

  describe 'POST #like' do
    context 'without authentication' do
      it 'should redirect to login page' do
        letter = Letter.create(description: "Ruby is awesome")
        post :like, params: {id: letter.id}
        expect(response).to redirect_to  %r(\Ahttp://test.host/users/sign_in)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'without authentication' do
      it 'should redirect to login page' do
        letter = Letter.create(description: "Ruby is awesome")
        delete :destroy, params: {id: letter.id}
        expect(response).to redirect_to  %r(\Ahttp://test.host/users/sign_in)
      end
    end
  end

end