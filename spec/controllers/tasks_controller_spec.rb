require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let!(:task) { create(:task, text: 'Existing Task', completed: false) }

  describe 'GET #index' do
    it 'returns a success response and a list of tasks' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq([{
        'id' => task.id,
        'text' => task.text,
        'completed' => task.completed,
        'created_at' => task.created_at.as_json,
        'updated_at' => task.updated_at.as_json
      }])
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) { { text: 'New Task', completed: false } }

      it 'creates a new task' do
        expect {
          post :create, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['text']).to eq('New Task')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      let(:valid_attributes) { { text: 'Updated Task', completed: true } }

      it 'updates the task and returns it' do
        put :update, params: { id: task.id, task: valid_attributes }
        task.reload

        expect(response).to have_http_status(:ok)
        expect(task.text).to eq('Updated Task')
        expect(task.completed).to be(true)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the task' do
      expect {
        delete :destroy, params: { id: task.id }
      }.to change(Task, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
