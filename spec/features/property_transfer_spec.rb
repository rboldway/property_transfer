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

  describe PropertyTransfer::PatternActionRegistry do

    before(:example) do
      @registry = described_class.new
    end

    example "register a esearch pattern and associated action" do
      expect(@registry.register("SS",:action)).to be_a(Hash)
      expect(@registry.register("SS",:action)).to include(/SS/ => :action)
    end

    example "upon match from a line, return the match content" do
      expect(@registry.register(/(country)/,:doit)).to include( {/(country)/ => :doit} )
      expect(@registry.upon_match("my country is")).to include( {:doit => "country"} )
    end

  end

end