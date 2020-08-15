require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'create' do
    it 'signup user' do
      user = { 'user': { 'email': 'test@test.com',
               'password': 'password' }
              }
      post :create, params: user
      token = JSON.parse(response.body)['token']
      expect(token).to be_kind_of(String)
      expect(response.status).to eq 200
    end

    it 'missing email' do
      user = { 'user': { 'email': '',
        'password': 'password' }
       }
      post :create, params: user
      error = JSON.parse(response.body)
      expect(error).to eq({"email"=>["can't be blank"]})
      expect(response.status).to eq 400
    end

    it 'missing password' do
      user = { 'user': { 'email': 'test@test.com',
        'password': '' }
       }
      post :create, params: user
      error = JSON.parse(response.body)
      expect(error).to eq({"password"=>["can't be blank"]})
      expect(response.status).to eq 400
    end
  end

  describe 'signin' do
    it 'authenticate user' do
      user = FactoryBot.create(:user)
      user = { 'user': { 'email': user.email,
               'password': user.password }
             }
      post :signin, params: user
      token = JSON.parse(response.body)['token']
      expect(token).to be_kind_of(String)
      expect(response.status).to eq 200
    end

    it 'can not sign in if user does not exists' do
      user = { 'user': { 'email': 'test@test.com',
               'password': '' }
             }
      post :signin, params: user
      error = JSON.parse(response.body)
      expect(error).to eq({"error"=>"Invalid Request"})
      expect(response.status).to eq 401
    end
  end
end