require 'spec_helper'

describe Lexile::Api::Books,  :vcr => { :cassette_name => "books" } do

  before { set_testing_configuration }


  context '#show' do
    let(:book){ Lexile.books.show(lexile_book_id) }

    it "should return result" do
      expect(book).to_not be_nil
    end

    it 'should be book' do
      expect(book).to be_an_instance_of( Lexile::Book )
    end

    it 'should have id key' do
      expect(book).to respond_to(:id)
    end

    it 'should have lexile key' do
      expect(book).to respond_to(:lexile)
    end

    it 'should have lexile_display key' do
      expect(book).to respond_to(:lexile_display)
    end

    it 'should have pages key' do
      expect(book).to respond_to(:pages)
    end
  end

  context '#find_by_isbn13' do
    let(:books){ Lexile.books.find_by_isbn13(lexile_book_isbn13) }

    it "should return not empty array" do
      expect(books).to_not be_nil
    end

    it 'first(10) should be array' do
      expect(books.first(10)).to be_an_instance_of( Array )
    end

    it 'count should be > 0' do
      expect(books.count).to_not be_zero
    end

    it 'should be array of Lexile::Book' do
      books.each do |book|
        expect(book).to be_an_instance_of( Lexile::Book )
      end
    end

    it 'should have id key' do
      expect(books.first).to respond_to(:id)
    end

    it 'should have lexile key' do
      expect(books.first).to respond_to(:lexile)
    end

    it 'should have lexile_display key' do
      expect(books.first(5)[0]).to respond_to(:lexile_display)
    end

    it 'should have pages key' do
      expect(books.first).to respond_to(:pages)
    end
  end

  context '#find_by_title' do
     let(:books){ Lexile.books.find_by_title(lexile_book_title) }

     it "should return not empty array" do
       expect(books).to_not be_nil
     end

     it 'first(10) should return array' do
       expect(books.first(10) ).to be_an_instance_of( Array )
     end

     it 'count should be > 0' do
       expect(books.count).to_not be_zero
     end

     it 'should be array of Lexile::Book' do
       books.each do |book|
         expect(book).to be_an_instance_of( Lexile::Book )
       end
     end

     it 'should have id key' do
       expect(books.first).to respond_to(:id)
     end

     it 'should have lexile key' do
       expect(books.first).to respond_to(:lexile)
     end

     it 'should have lexile_display key' do
       expect(books.first).to respond_to(:lexile_display)
     end

     it 'should have pages key' do
       expect(books.first).to respond_to(:pages)
     end
   end


end