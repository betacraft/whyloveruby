require 'rails_helper'

RSpec.describe LettersController, type: :controller do
  params = { params: { letter: { description: 'Ruby is awesome' } } }
  describe 'POST #create' do
    context 'without authentication' do
      it 'should redirect to login page' do
        post :create, params
        expect(response).to redirect_to %r{\Ahttp://test.host/users/sign_in}
      end
    end

    context 'with authentication' do
      login_user
      it 'should redirect to letter path after save' do
        post :create, params
        expect(response).to redirect_to letter_path(1)
      end

      it 'should render success flash after save' do
        post :create, params
        expect(flash[:notice]).to eq 'Saved successfully !'
      end

      it 'should render error flash with empty description' do
        post :create, params: { letter: { description: '' } }
        expect(flash[:error]).to eq 'Letter description cannot be empty. Try Again!'
      end

      it 'should redirect to root with empty description' do
        post :create, params: { letter: { description: '' } }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET #show' do
    before(:all) do
      @letter = create(:letter)
    end
    context 'without authentication' do
      it 'return http success' do
        get :show, params: { id: @letter.id }
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'GET #edit' do
    before(:all) do
      @letter = create(:letter)
    end
    context 'without authentication' do
      it 'should redirect to login page' do
        get :edit, params: { id: @letter.id }
        expect(response).to redirect_to %r{\Ahttp://test.host/users/sign_in}
      end
    end
  end

  describe 'PATCH #update' do
    before(:all) do
      @letter = create(:letter)
    end
    context 'without authentication' do
      it 'should redirect to login page' do

        patch :update, params:{ id: @letter.id }
        expect(response).to redirect_to %r{\Ahttp://test.host/users/sign_in}
      end
    end

    context 'with authentication' do
      login_user
      it 'should redirect to letter path after update' do
        letter = subject.current_user.letters.create(description: 'Ruby is awesome')
        patch :update, params: { id: letter.id, letter: { description: 'Ruby is Awesome and productive' } }
        expect(response).to redirect_to letter_path(letter.id)
      end

      it 'should render success flash after update' do
        letter = subject.current_user.letters.create(description: 'Ruby is awesome')
        patch :update, params: { id: letter.id, letter: { description: 'Ruby is Awesome and productive' } }
        expect(flash[:notice]).to eq 'Updated Successfully !!'
      end

      it 'should render error flash with empty description' do
        letter = subject.current_user.letters.create(description: 'Ruby is awesome')
        patch :update, params: { id: letter.id, letter: { description: '' } }
        expect(flash[:error]).to eq 'Letter description cannot be empty. Try Again!'
      end
    end
  end

  describe 'POST #like' do
    before(:all) do
      @letter = create(:letter)
    end
    context 'without authentication' do
      it 'should redirect to login page' do
        post :like, params: { id: @letter.id }
        expect(response).to redirect_to %r{\Ahttp://test.host/users/sign_in}
      end
    end

    context 'with authentication' do
      login_user
      it 'should render json' do
        post :like, params: { id: @letter.id }
        expected = { 'success' => true, 'message' => 'Like saved..','likes' => @letter.likes.count, 'id' => @letter.id }
        expect(JSON.parse(response.body))== expected
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:all) do
      @letter = create(:letter)
    end
    context 'without authentication' do
      it 'should redirect to login page' do
        delete :destroy, params: { id: @letter.id }
        expect(response).to redirect_to %r{\Ahttp://test.host/users/sign_in}
      end
    end

    context 'with authentication' do
      login_user
      it 'should render success flash after delete' do
        letter = subject.current_user.letters.create(description: 'Ruby is awesome')
        delete :destroy, params: { id: letter.id }
        expect(flash[:notice]).to eq 'Letter has been successfully deleted'
      end

      it 'should redirect to root_path after delete' do
        letter = subject.current_user.letters.create(description: 'Ruby is awesome')
        delete :destroy, params: { id: letter.id }
        expect(response).to redirect_to root_path
      end
    end
  end
end
