class StartVerify

  # ############## WEB BELOW ##############
  # #Call: StartVerify.run
  def self.run

    # curler = VerifyUrl::Curler.new.start_curl('url', 10)
    # ------------ Curler as Module ------------
    #Y! self_test_curl = VerifyUrl::Curler.self_test_curl
    # ------------ Curler as Class ------------
    #Y! self_test_curl = VerifyUrl::Curler.self_test_curl
    #Y! test_curl = VerifyUrl::Curler.new.test_curl
    # ----------------------------------------------
    curler_runner = VerifyUrl::RunCurler.new
    urls = grab_sample_urls
    curler_hashes = curler_runner.verify_urls(urls)

    # @web_formatter = CRMFormatter::Web.new
    # url = "http://www.grossinger.com/"
    # @web_formatter.format_url(url)
    binding.pry
  end

  def self.grab_sample_urls
    urls = ["http://www.blackwellford.com", "http://www.bobilya.com", "http://www.century1chevy.com", "http://www.hammondautoplex.com", "http://www.harbinfordscottsboro.net", "http://www.lancaster.subaru.com", "http://www.loufusz.subaru.com", "http://www.mastro.subaru.com", "http://www.mccrea.subaru.com", "http://www.minooka.subaru.com", "http://www.muller.subaru.com", "http://www.reinekefamilydealerships.com", "http://www.texarkana.mercedesdealer.com", "http://www.verneidegm.com", "http://www.william-lehman.subaru.com", "https://www.applefordyork.com", "https://www.baldwinford.com", "https://www.buckhead.mercedesdealer.com", "https://www.chryslerjeepdodgeramofrenton.com", "https://www.fordgroves2.com"]

    # fwds = ["http://www.centurychevy.com", "http://www.dealershipblackhole.com", "http://www.verneidegm.net", "https://www.blackwellford.com", "https://www.bobilyachryslerdge.com", "https://www.drivereineke.com", "https://www.harbinfordscottsboro.com", "https://www.lancastercountysubaru.com", "https://www.lehmansubaru.com", "https://www.mastrosubaru.com", "https://www.mccreasubaru.com", "https://www.mercedesoftexarkana.com", "https://www.minookasubaru.com", "https://www.mullersubaru.com", "https://www.subaru.fusz.com"]

    # fwds
    urls[3..-1]
  end

  # ############## WEB BELOW ##############
  # #Call: StartVerify.run_webs
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
  # end

end

# address = CRMFormatter::Address.new
# address.gh
# StartVerify.new.one
# StartVerify.new.state
# StartVerify.new.self_state
# CRMFormatter::Address.new.state
# CRMFormatter.crm
# StartVerify.new.start_greet
# StartVerify.new.crm_greet
# CRMFormatter.crm_greet
# CRMFormatter.state
