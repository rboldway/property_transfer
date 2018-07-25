=begin

Start line ex: Property Purchase Price

Section (city) line ex: Burlington
could be multi-words

Property line ex: 8023 Wheatland Road;$435,000 
could wrap around to next line
Regular Expression could possibly mend two lines together but
I think its better to log the orginal lines then do a vlidation of the
address using USPS address validation API. Once address is valid then insert into
database.

=end

class PropertyTransfer

  attr_accessor :input, :io, :registry, :city

  def initialize(document)
    # replace unicode LS with ascii newline
    @input = document.gsub(/\u2028/,"\n")
    # puts @input
    @io = StringIO.new @input
    @registry = {}
    @last_line = nil
  end

  Properties = {}

  def register(pattern, action)
    registry[Regexp.new(pattern)] = action
  end

  def perform_upon_match(line)
    content = nil
    key = nil
    registry.keys.detect do |k|
      content = line.match(k)
      key = k
      content
    end
    send(registry[key], content) if content
    @last_line = content
  end

  def seek_content(pattern,io)
    content = nil
    io.each_line do |line|
      break if (content = line.match(pattern))
    end
    content
  end

  def city(content)
    @city = content[1].to_s.chomp.squeeze(" ")
    # puts ":city #{@city}"
  end

  def property(property)
    property = property.to_a.drop(1)
    price = property.pop
    property[0].squeeze(" ")
    property << @city << "WI" << price
    puts property.join(", ")
  end

  def run
    register(/^([0-9A-Za-z ]+)[,:; ]+\$([0-9,]+)$/, :property)
    register(/^([A-Z a-z-]{2,})$/,:city)

    puts "\nStart of prices: #{seek_content(/Property Purchase Price/, io)}"

    # loop thru lines sequentiallly
    io.each_line do |line|
      perform_upon_match(line)
    end
  end

end

transfer = PropertyTransfer.new document
transfer.run


