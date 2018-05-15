class StartCrm

  # # #Call: StartCrm.run_webs
  # def self.run_webs
  #   web = CRMFormatter::Web.new
  #   # hsh = web.format_url('http://www.bobilya.com/adam_testing')
  #   hsh = web.check_pos_neg('target', 'hash')
  #   binding.pry
  # end


  # #Call: StartCrm.run_webs
  def self.run_webs
    oa_args = get_args
    web = CRMFormatter::Web.new(oa_args)
    # web = CRMFormatter::Web.new
    urls = get_urls

    formatted_url_hashes = urls.map do |url|
      url_hash = web.format_url(url)
    end

    binding.pry
  end



  def self.get_args
    neg_urls = %w(approv avis budget collis eat enterprise facebook financ food google gourmet hertz hotel hyatt insur invest loan lube mobility motel motorola parts quick rent repair restaur rv ryder service softwar travel twitter webhost yellowpages yelp youtube)

    pos_urls = ["acura", "alfa romeo", "aston martin", "audi", "bmw", "bentley", "bugatti", "buick", "cdjr", "cadillac", "chevrolet", "chrysler", "dodge", "ferrari", "fiat", "ford", "gmc", "group", "group", "honda", "hummer", "hyundai", "infiniti", "isuzu", "jaguar", "jeep", "kia", "lamborghini", "lexus", "lincoln", "lotus", "mini", "maserati", "mazda", "mclaren", "mercedes-benz", "mitsubishi", "nissan", "porsche", "ram", "rolls-royce", "saab", "scion", "smart", "subaru", "suzuki", "toyota", "volkswagen", "volvo"]

    # neg_links = %w(: .biz .co .edu .gov .jpg .net // afri anounc book business buy bye call cash cheap click collis cont distrib download drop event face feature feed financ find fleet form gas generat graphic hello home hospi hour hours http info insta inventory item join login mail mailto mobile movie museu music news none offer part phone policy priva pump rate regist review schedul school service shop site test ticket tire tv twitter watch www yelp youth)

    # neg_hrefs = %w(? .com .jpg @ * afri after anounc apply approved blog book business buy call care career cash charit cheap check click collis commerc cont contrib deal distrib download employ event face feature feed financ find fleet form gas generat golf here holiday hospi hour info insta inventory join later light login mail mobile movie museu music news none now oil part pay phone policy priva pump quick quote rate regist review saving schedul service shop sign site speci ticket tire today transla travel truck tv twitter watch youth)

    neg_exts = %w(au ca edu es gov in ru uk us business site)

    oa_args = {neg_urls: neg_urls, pos_urls: pos_urls, neg_exts: neg_exts}

    # pos_urls
    # neg_urls
    # pos_links
    # neg_links
    # pos_hrefs
    # neg_hrefs
    # pos_exts
    # neg_exts
    # min_length
    # max_length
  end


  def self.get_urls
    # urls1 = Web.where(url_sts: 'Invalid').where.not("url LIKE '%.site%'").pluck(:url)
    # urls = urls1.sort { |x,y| y.length <=> x.length }
    # urls[0..50]

    ["https://www.stevenscreekmitsubishiserviceandpartscenter.com", "https://www.performancechryslerjeepcenterville.com", "http://www.performancechryslerjeepcenterville.com", "http://www.colliervillechryslerdodgejeepram.com", "http://www.greatlakeschryslerdodgejeepram.com", "https://www.motorvillagechryslerdodgejeep.com", "https://www.allstarvolvocarsofbatonrouge.com", "https://www.premiervolvocarsoverlandpark.com", "http://www.toyotaofberkeleyservicecenter.com", "https://www.chryslerjeepdodgeramofrenton.com", "https://www.hertzcarsalescoloradosprings.com", "https://www.hertzcarsalesphoenixbellroad.com", "http://www.automobileconsultingservices.com", "https://www.alfaromeousaofcentervilleoh.com", "https://www.hertzcarsalesstonemountain.com", "http://www.precisionfleetservicestempe.com", "http://www.alsdetailingsalesandservice.com", "http://www.brentberghegerchryslerdodge.com", "http://www.seattlemotorsportsshoreline.com", "http://www.upstateautoservicebodyworks.com", "http://minnesotacarloancreditfinancing.com", "https://www.hertzcarsalesjacksonville.com", "http://www.watsonsautosalesandfinance.com", "https://www.hertzcarsaleswinstonsalem.com", "https://www.hertzcarsaleshoustonsouth.com", "http://www.autofairvolkswagenofnashua.com", "https://www.hertzcarsalespompanobeach.com", "https://www.hertzcarsalessanfrancisco.com", "http://www.countrysideautobodyservice.com", "http://www.napletonjaguarschererville.com", "https://www.hertzcarsalessaltlakecity.com", "http://futurefordtruckrvservicecenter.com", "https://www.allstarvolvoofbatonrouge.com", "http://www.dondavisdodgechryslerjeep.com", "https://www.faulknervolvocarstrevose.com", "http://www.dondavischryslerdodgejeep.com", "https://www.lithiachryslergreatfalls.com", "https://www.imageautosalesandservice.com", "http://alfaromeousaoffairviewheights.com", "https://www.fallschurchdonbeyervolvo.com", "https://www.hertzcarsalesorlandoeast.com", "https://www.hertzcarsalescrystallake.com", "https://www.hertzcarsalesalbuquerque.com", "http://www.mikehatchsalesandservice.com", "http://www.greaterbostonmotorsports.com", "http://www.watervillewhitehouseford.com", "https://www.hertzcarsalessantaclara.com", "http://www.excellentchoiceautosales.com", "https://www.hertzcarsalesclearwater.com", "http://davisautosales.motorcarsites.com", "https://www.hertzcarsalesrichardson.com"]
  end












  # ############## PHONE BELOW ##############
  # #Call: StartCrm.run_phones
  # def self.run_phones
  #   crm_phone = CRMFormatter::Phone.new
  #   fk_phone = Faker::PhoneNumber
  #   fk_adr = Faker::Address
  #   phones = 5.times.map { fk_phone.phone_number }
  #   phones += 5.times.map { fk_phone.cell_phone }
  #   phones += 2.times.map { fk_adr.street_address }
  #   phones += 2.times.map { fk_adr.zip_code }
  #   phones += 2.times.map { fk_adr.latitude }
  #   phones.shuffle!
  #   formatted_phone_hashes = phones.map { |ph| crm_phone.validate_phone(ph) }
  #   binding.pry
  #   formatted_phone_hashes
  # end
  #
  #
  #
  # ############## ADDRESS BELOW ##############
  # #Call: StartCrm.run_adrs
  # def self.run_adrs
  #   address = CRMFormatter::Address.new
  #
  #   address_hashes = 5.times.map do
  #     fk = Faker::Address
  #     adr_hsh = { street: fk.street_address.downcase, city: fk.city.downcase, state: fk.state.downcase, zip: fk.zip_code }
  #   end
  #
  #   formatted_address_hashes = address_hashes.map do |adr_hsh|
  #     address.format_full_address(adr_hsh)
  #   end
  #
  #   binding.pry
  #   formatted_address_hashes
  # end
  #
  # ############## WEB BELOW ##############
  # #Call: StartCrm.run_webs
  # def self.run_webs
  #   url_red_flags = %w(approv avis budget business collis eat enterprise facebook financ food google gourmet hertz hotel hyatt insur invest loan lube mobility motel motorola parts quick rent repair restaur rv ryder service softwar travel twitter webhost yellowpages yelp youtube)
  #
  #   link_red_flags = %w(: .biz .co .edu .gov .jpg .net // afri anounc book business buy bye call cash cheap click collis cont distrib download drop event face feature feed financ find fleet form gas generat graphic hello home hospi hour hours http info insta inventory item join login mail mailto mobile movie museu music news none offer part phone policy priva pump rate regist review schedul school service shop site test ticket tire tv twitter watch www yelp youth)
  #
  #   href_red_flags = %w(? .com .jpg @ * afri after anounc apply approved blog book business buy call care career cash charit cheap check click collis commerc cont contrib deal distrib download employ event face feature feed financ find fleet form gas generat golf here holiday hospi hour info insta inventory join later light login mail mobile movie museu music news none now oil part pay phone policy priva pump quick quote rate regist review saving schedul service shop sign site speci ticket tire today transla travel truck tv twitter watch youth)
  #
  #   ext_red_flags = %w(au ca edu es gov in ru uk us)
  #
  #   args = { url_red_flags: url_red_flags, link_red_flags: link_red_flags, href_red_flags: href_red_flags, ext_red_flags: ext_red_flags }
  #   web = CRMFormatter::Web.new(args)
  #
  #   urls = %w(http://thiel.com/chauncey_mobile http://thiel.com/ www.thiel.com thiel.com/chauncey_simonis thiel.com www.example.com/join-us-hello)
  #
  #   validated_url_hashes = urls.map { |url| web.format_url(url) }
  #   valid_urls = validated_url_hashes.map { |hsh| hsh[:valid_url] }.compact
  #   extracted_link_hashes = urls.map { |url| web.extract_link(url) }
  #   links = extracted_link_hashes.map { |hsh| hsh[:link] }.compact
  #   validated_link_hashes = links.map { |link| web.remove_invalid_links(link) }
  #   hrefs = ["Hot Inventory", "Join Our Sale!", "Don't Wait till Later", "Apply Today!", "No Cash Down!"]
  #   validated_href_hashes = hrefs.map { |href| web.remove_invalid_hrefs(href) }
  #   binding.pry
  #   ############# WEB ABOVE ##############
  #
  # end

end


# address = CRMFormatter::Address.new
# address.gh

# StartCrm.new.one
# StartCrm.new.state
# StartCrm.new.self_state
# CRMFormatter::Address.new.state



# CRMFormatter.crm

# StartCrm.new.start_greet
# StartCrm.new.crm_greet

# CRMFormatter.crm_greet

# CRMFormatter.state
