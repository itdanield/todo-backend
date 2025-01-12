require 'rails_helper'

RSpec.describe Task, type: :model do
  # Testowanie walidacji
  describe 'validations' do
    it 'is valid with valid attributes' do
      task = Task.new(text: 'Example task', completed: false)
      expect(task).to be_valid
    end

    it 'is valid without attributes' do
      task = Task.new(text: nil, completed: false)
      expect(task).to be_valid
    end
  end
end
