require 'rails_helper'

describe ApplicationHelper, type: :helper do
   
   describe '#markdown' do

     it 'renders HTML from a markdown String' do
       text = '**Moomin!**'
       expect(helper.markdown(text)).to eq("<p><strong>Moomin!</strong></p>\n")
     end

     it 'raises a TypeError if input is not a String' do
       invalid_input = 123
       expect{ helper.markdown(invalid_input) }.to raise_error(TypeError)
     end
   end

   describe '#inline_markdown' do

    it 'strips enclosing <p> tags' do
      text = '**Moomin!**'
      expect(helper.inline_markdown(text)).to eq("<strong>Moomin!</strong>")
    end

    it 'leaves enclosing <p> tags if there are internal <p> tags' do
      text = '<p>Moomin!</p><p>Snorkmaiden</p>'
      expect(helper.inline_markdown(text))
        .to eq("<p>Moomin!</p><p>Snorkmaiden</p>\n")
    end
  end
end
