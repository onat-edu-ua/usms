require 'rails_helper'

RSpec.describe Api::StudentsController, type: :controller do
  include_context :api_test_helper

  describe 'GET show' do
    subject { get :show, id: student_id, format: :json }

    let(:student) { create(:student) }
    let(:student_id) { student.id }

    context 'valid' do
      it 'should return correct json' do
        subject
        expect(response.status).to eq 200
        expect(response_body.except('created_at', 'updated_at')).to eq student.attributes.except('created_at', 'updated_at', 'password')
      end
    end

    context 'invalid id' do
      let(:student_id) { 9999 }
      it 'should return 404' do
        subject
        expect(response.status).to eq 404
        expect(response_body).to eq({'error' => 'not-found'})
      end
    end

    context 'wrong id format' do
      let(:student_id) { 'rspec' }
      it 'should return 404' do
        subject
        expect(response.status).to eq 404
        expect(response_body).to eq({'error' => 'not-found'})
      end
    end

  end

  describe 'GET authenticate' do
    subject { get :authenticate, format: :json, login: student_login, password: student_password }

    let(:student) { create(:student) }
    let(:student_login) { student.login }
    let(:student_password) { student.password }

    context 'valid student' do
      it 'should return correct body' do
        subject
        expect(response.status).to eq 200
        expect(response_body.except('created_at', 'updated_at')).to eq student.attributes.except('created_at', 'updated_at', 'password')
      end
    end

  end

end
