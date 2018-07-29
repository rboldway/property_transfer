require 'property_transfer'

RSpec.describe PropertyTransfer do
  describe PropertyTransfer::RecordTransfer do

    def make_file
      str = "    Property Purchase Price\n"
      StringIO.new str
    end

    before(:example) do
      @document = make_file
      @recording = described_class.new @document
    end

    example "document is a StringIO object" do
      expect(@document).to be_a StringIO
    end

    example "seek a position into file" do
      expected = "Property Purchase Price"
      expect(@recording.seek_content(expected)).to match /\s*Property Purchase Price\s*/
    end

  end

end