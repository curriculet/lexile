require 'spec_helper'

describe Lexile::Model do


  describe "#parse" do
    # We will use a Lexile::Book which is a model to test model properties
    let(:single_object_response){ { 'a' => 'ONE', 'b' => 'TWO', 'c' => 'THREE'} }
    let(:multi_object_response){{ 'objects' =>[{ 'a' => 'ONE', 'b' => 'TWO', 'c' => 'THREE'},{ 'a' => 'UNO', 'b' => 'DOS', 'c' => 'TRES'},{ 'a' => 'UNE', 'b' => 'DEUX', 'c' => 'TROIS'}] }}
    let(:invalid_json){ { 'objects' => 'Most Definetly not an array of objects'} }

    it "should raise an exception if a mult-object response does not contain an array" do
      expect{
        Lexile::Book.parse( invalid_json )
      }.to raise_error Lexile::CannotProcessResponse, /is present in response but it does not contain an Array/
    end

    it "should parse a single object response" do
      soj = Lexile::Book.parse( single_object_response )
      single_object_response.each do |key|
        soj[key].should eq single_object_response[key]
      end
    end

    it "should parse a multi object response" do
      books = Lexile::Book.parse( multi_object_response )
      objs = multi_object_response['objects']
      books.length.should eq objs.length
      #deep compare of books
      objs.each do |obj|
        index = books.find_index{|book| book['a']== obj['a']}
        index.should_not be_nil
        book = books[index]
        obj.each do |key|
          book[key].should eq obj[key]
        end
      end
    end
  end

end