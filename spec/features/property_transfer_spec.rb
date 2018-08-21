require 'property_transfer'

RSpec.describe PropertyTransfer do

  describe PropertyTransfer::RecordTransfer do

    example "delegate register method" do
      expect(respond_to(:register))
    end

    example "delegate upon_match method" do
      expect(respond_to(:upon_match))
    end

  end


  describe PropertyTransfer::RecordTransfer do

    example "transform input to output" do
      allow(ARGF)
          .to receive(:gets)
          .and_return("  Property Purchase Price", "Anywhere", "123 Elm Street $123,000", "444 Emerald Blvd $222,222", "Nowhere", "333 Heap Court $999,999", nil)

      expect(STDOUT).to receive(:puts).with( {:state=>"WI", :city=>"Anywhere", :address=>"123 Elm Street", :price=>"123,000"} )
      expect(STDOUT).to receive(:puts).with( {:state=>"WI", :city=>"Anywhere", :address=>"444 Emerald Blvd", :price=>"222,222"})
      expect(STDOUT).to receive(:puts).with( {:state=>"WI", :city=>"Nowhere", :address=>"333 Heap Court", :price=>"999,999"} )

      described_class.new.run
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