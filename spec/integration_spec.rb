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

  describe FreebaseImporters::President do
    let (:president) { FreebaseImporters::President.first }
    it "should have attributes" do
      [:name, :id, :height_meters].each do |attr|
        expect(president.send(attr)).not_to be_nil
      end
    end
  end

  describe FreebaseImporters::Car do
    let(:car) { FreebaseImporters::Car.first }
    it "should have images and thumbnails" do
      expect(car.thumbnail_urls).not_to be_empty
      expect(car.image_urls).not_to be_empty
    end

    describe :endless do
      it "should return a second page of results" do
        counter = 0
        images  = []
        FreebaseImporters::Car.endless(0) do |car|
          counter += 1
          images << car.image_url if counter < 50
          if counter > 120
            expect(images).not_to include(car.image_url)
            break
          end
        end
      end
    end
  end

  describe FreebaseImporters::Person do
    let(:person) { FreebaseImporters::Person.first }
    it "should have name" do
      expect(person.name).to match /\w+/
    end
  end
end