require 'rails_helper'

RSpec.describe FileUpload, type: :model do
    let(:file_upload) { FileUpload.new(name: "foo") }
  
    context 'traverses trees with height=1' do
        it 'gives the right gender' do
            file_upload.traverse(1, 1, 0, '')
            expect(file_upload.genders).to eq 'M'
        end
    end

    context 'traverses edge cases' do
        it 'gives the right gender for the left-most children' do
            file_upload.traverse(1, 100000000, 1, '')
            expect(file_upload.genders).to eq 'M'
        end
   
        it 'gives the right gender for the second left-most child' do
            file_upload.traverse(1, 100000000, 2, '')
            expect(file_upload.genders).to eq 'F'
        end
        
        it 'gives the right gender for the right-most children' do
            file_upload.traverse(1, 100000000+1, 2**(100000000-1), '')
            expect(file_upload.genders).to eq 'M'
        end

        it 'gives the right gender for the second right-most child' do
            file_upload.traverse(1, 100000000, 2**(100000000-1), '')
            expect(file_upload.genders).to eq 'F'
        end
    end

    context 'the gender pattern is repeated for every 32 children of the same generation' do
        it 'gives the same gender for any 32th child' do
            file_upload.traverse(1, 7, 1, '')
            file_upload.traverse(1, 7, 33, '')
            file_upload.traverse(1, 7, 65, '')
            file_upload.traverse(1, 7, 97, '')
            expect(file_upload.genders).to eq 'MMMM'

            file_upload.genders = ''
            file_upload.traverse(1, 7, 3, '')
            file_upload.traverse(1, 7, 35, '')
            file_upload.traverse(1, 7, 67, '')
            file_upload.traverse(1, 7, 99, '')
            expect(file_upload.genders).to eq 'FFFF'

            file_upload.genders = ''
            file_upload.traverse(1, 8, 3, '')
            file_upload.traverse(1, 8, 35, '')
            file_upload.traverse(1, 8, 67, '')
            file_upload.traverse(1, 8, 99, '')
            file_upload.traverse(1, 8, 131, '')
            file_upload.traverse(1, 8, 163, '')
            expect(file_upload.genders).to eq 'FFFFFF'
        end
        
    end    
end