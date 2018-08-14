require 'property_transfer'

RSpec.describe PropertyTransfer do
  describe PropertyTransfer::RecordTransfer do

    def make_file
      str = "    Property Purchase Price\nAnywhere\n123 Elm Street $123,000\n444 Emerald Blvd $222,222\nNowhere\n333 Heap Court $999,999\n"
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

    example "delegate register method" do
      expect(respond_to(:register))
    end

    example "delegate upon_match method" do
      expect(respond_to(:upon_match))
    end

    example "strip leading and trailing whitespace, squeeze multi-spaces to one and set the city variable" do
      expect(@recording.city(" Van Nuys  ")).to eq "Van Nuys"
    end

  end

  describe PropertyTransfer::PatternActionRegistry do

    before(:example) do
      @reg = described_class.new
    end

    example "register a search pattern and associated action" do
      expect(@reg.register({/SS/ => :action})).to include(/SS/ => :action)
    end

    example "upon match from a line, return the match content" do
      expect(@reg.register( {/(?<city>country)/ => :doit})).to include( {/(?<city>country)/ => :doit} )
      expect(@reg.upon_match("my country is")).to include( {"city" => "country", :action => :doit} )
    end

  end

end