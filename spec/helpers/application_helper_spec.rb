require 'spec_helper'

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
end
