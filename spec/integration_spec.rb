require "spec_helper"

puts "This makes unstubbed API requests right now. Woo"

describe FreebaseImporters do
  it "should be a module" do
    expect(FreebaseImporters).to be_a_kind_of Module
  end

  describe FreebaseImporters::Book do
    let(:book) { FreebaseImporters::Book.first }
    it "should have a name" do
      expect(book.name).to match /\w+/
    end
  end

  describe FreebaseImporters::Car do
    let(:car) { FreebaseImporters::Car.first }
    it "should have images and thumbnails" do
      expect(car.thumbnail_urls).not_to be_empty
      expect(car.image_urls).not_to be_empty
    end
  end

  describe FreebaseImporters::Person do
    let(:person) { FreebaseImporters::Person.first }
    it "should have name" do
      expect(person.name).to match /\w+/
    end
  end
end