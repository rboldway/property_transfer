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

document = <<FILE
C4 I SUNDAY, JULY 8, 2018

MONEY

THE JOURNAL TIMES

PROPERTY TRANSFERS

June 18-22 and June 25-29 Each week The Journal Times will run a list of properties where the title has either been transferred or sold, as recorded by the Racine County Register of Deeds office. The value, or estimated sale price, is determined by the cost of the transfer tax recorded in the deed. Property Purchase Price Burlington
8023 Wheatland Road;$435,000 1807 Landre Court;$299,400 1165 Hidden Creek Lane:$245,000 8020 Sage St.;$239,900 1330 River Knoll St.;$235,000 900 Milwaukee Ave.;$l95,000 3219 Crossway Road;$184,000 117 Kendall St.;$172,000 506 Briody St.;$164,500 33410 Cattail Drive;$156,500 256 S. Perkins Blvd.;$152,900 604 Browns Lake Drive;$140,000 300 S. Teut Road;$12,000 Caledonia
13629 Northwestern Ave.;$l,500,000 6216 Bel Mar Ave.;$515,000 3127 Fenceline Road;$338,000 4444 N. Green Bay Road ;$286,400 3515 Corona Lane;$285,900 5747 Winstar Lane;$250,000 5319 Willowview Road;$226,000 8423 7 Mile Road;$189,900 13418 7 Vi Mile Road;$189,500 9901 Dunkelow Road;$185,000 4431 State Road 31;$154,500

5795 Stefanie Way;$119,900 6131 Highway H;$110,000 1905 Kremer Ave.;$92,000
Dover
2200 S. Britton Road;$465,000 22130 Schroeder Road;$299,900 4420 Sheard Road;$269,900 Mount Pleasant 1533 S. Green Bay Road;$l,020,000 2302 Raintree Lane;$379,000 2543 Markridge Drive;$355,000 6403 Anforest Lane;$340,400 2107 Newman Road;$340,000 6520 Wembly Lane;$338,000 6520 Wembly Lane;$336,500 1827 Trevino Trail;$330,000 614 Hunter Drive;$311,000 3420 Chicory Road;$305,000 6048 Independence Road;$283,500
412 Quail Point Drive;$279,900 2213 Spring Meadow Lane;$278,500 2405 Racine St.;$277,000 6234 Larchmont Drive;$265,000 5815 Independence Road;$230,000
4309 Chekanoff Drive;$230,000 6223 Hilltop Drive;$218,000 5008 Campfire Lane;$215,000 3125 Wander Lane;$215,000 5855 Kinzie Ave., Unit 37;$184,000
1459 Sunnyslope Drive, Unit 21;$182,500
1134 Sunnyslope Drive, No. 204;$182,000

4237 Taylor Harbor, Unit 6;$153,000
2820 Cozy Acres Road;$125,000 3154 Wood Road, Unit 14;$125,000
3016 Meyer Court, No. 7;$ll9,000 858 Boulder Trail, No. 302;$117,500
1715 Wiese Lane Mount;$115,000 5608 Cambridge Lane, No. 4;$99,900
1017 Stratford Court;$67,400 3224 Wood Road;$65,000 10051 Camelot Drive;$48,000 1156 Sunnyslope Drive, No. 104;$41,500 Norway
3651	South Hillcrest Road;$396,000
26023 Barberry Lane;$297,500 7515 S. Loomis Road;$280,000
Racine
4 Gaslight Drive, No. 404;$330,000 4001 Haven Ave.;$270,000 954 Washington Ave.;$260,000 333 Lake Avenue, No. 306;$220,500
2100 Northwestern Ave.;$200,000
2200 Northwestern Ave.;$200,000 926 Kentucky St.;$190,000 2811 Delaware Ave.;$184,900
3652	Carter St.;$179,900 705 Augusta St.;$176,000 2509 Illinois St.;$175,000 3520 Erie St.;$170,000

1418 Park Ave.;$170,000 3320 Debra Lane;$168,900 807 Mayfair Drive;$166,700 921 Monroe Ave.;$160,000 1301 Romayne Ave.;$157,900 1009 Blaine Ave.;$154,500 2007 Harriet St.;$150,000 2414 Drexel Ave.;$145,000 2530 Northwestern Ave.;$140,000 2215 Georgia Ave.;$136,500 2900 Webster St.;$135,000 1928 Gilson St.;$134,500 1428 Grange Ave.;$132,900 1121 Cleveland Ave.;$130,000 3618 Charles St.;$130,000 321 Main St.;$128,000 2505 Grove Ave.;$126,000 3620 Osborne Blvd.;$121,000 2908 West Lawn Ave.;$119,000 2422 Geneva St.;$118,000 819 William St.;$116,305 2014 Webster St.;$112,000 4400 Blue River Ave.;$lll,500 736 Willmor St.;$lll,000 1416 Melvin Ave.;$110,000 1521 College Ave.;$109,000 2821 Erie St.;$108,000 1137 Park Ave.;$105,000 1949 Lawn St.;$101,562 709 Willmore St.;$101,000 800 Illinois St.;$100,000 1915 Jupiter Ave.;$93,000 2028 Phillips Ave.;$89,000 1924 Green St.;$87,500 2723 Hamilton Ave.;$82,000 1004 Grove Ave.;$82,000 3718 Wright Ave.;$80,000

2808 La Salle St.;$79,500 1949 Lawn St.;$78,000 1217 Jones Ave.;$77,500 1617 Monroe Ave.;$76,219 1716 Linden Ave.;$68,000 1312 Center St.;$64,000 2052 N. Main St.;$60,000 141712th St.;$60,000 206 Belmont Ave.;$60,000 3603 St. Andrews Court, No. 106;$57,000
1624 Charles St.;$53,500 2711 Geneva St.;$53,300 2063 Charles St.;$52,000 1769 Illinois St.;$50,000 329 Wickham Blvd.;$42,350 213 Frank Ave.;$33,000 929 N. Memorial Drive;$31,000 1911 FairviewTerrace;$20,000 1937 Center St.;$14,400 1510 Liberty St.;$ll,591 2102 Northwestern Ave.;$10,000 Raymond
4325 S. 27th St.;$760,000 6731W. 3 Mile Road;$387,500
Rochester
2818 N. River Road; $362,550 32625 Vista View Drive;$350,000 32815 Seidel Drive;$263,000 2706 North River Road;$243,500 262 Oak Hill Cirde;$46,800 Sturtevant
8624 Citadel Terrace;$295,000 8725 Camelot Trace;$232,500 3325 90th St.;$180,000 9700 Rayne Road, No. 5;$86,600 9409 Carol Ann Drive;$60,200 Union Grove

1342 Groves Lane;$224,000 1612 State St.;$171,000 923 Park Circle, Unit 23;$163,000 1324 High St.;$149,900 731 Vine St.;$139,500 1358 Main St.;$85,000 Waterford
5653 Island View Court;$565,000 825 Ela Ave.;$425,000 6533 Willow Lane;$347,500 797 Meadowgate Drive;$341,400 855 Meadowgate Drive;$315,000 860 Still Pond Drive:$309,900 606 Woodland Circle;$287,500 516 Fairview Circle;$255,000 472 Woodfield Cirde;$254,000 541B Fairview Circle;$228,900 240 Marina Court, No. 18;$205,000
29134 White Oak Lane;$l99,900 5826 River Bay Road N;$196,000 6641 Hillstone Court;$74,000
Wind Point
105 Lamplighter Lane;$380,000 10 Ironwood Court;$327,500 6 Cedarwood Court;$282,800 115 Eldorado Drive;$270,000 33 Lakewood Drive;$240,000 Yorkville
107 63rd Drive;$460,000 17808 58th Road;$394,587 16220 Durand Ave.;$220,000 16220 Durand Ave.;$145,000 15012 Kingston Way;$109,000
FILE

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


