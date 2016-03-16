require 'rails_helper'

describe SequencesController, type: :controller do
  context 'admin logged in' do
    login_admin

    describe '#sort' do
      it 'updates sequence positions' do
        s1 = create(:sequence_factory, vocabulary_id: 1, tag_id: 1, position: 0)
        s2 = create(:sequence_factory, vocabulary_id: 1, tag_id: 2, position: 1)
        post :sort, sequence: [s2.id, s1.id]
        expect(s2.reload.position).to eq 0
        expect(s1.reload.position).to eq 1
      end

      it 'renders nothing' do
        post :sort, sequence: []
        expect(response.body).to be_blank
      end
    end
  end
end
