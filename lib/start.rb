class Start


  ############## PHONE BELOW ##############
  phone = CRMFormatter::Phone.new

  fk_phone = Faker::PhoneNumber
  fk_adr = Faker::Address
  phones = 2.times.map { fk_phone.phone_number }
  phones += 2.times.map { fk_phone.cell_phone }
  phones += 2.times.map { fk_adr.street_address }
  phones += 2.times.map { fk_adr.zip_code }
  phones += 2.times.map { fk_adr.latitude }
  phones.shuffle!

  formatted_phone_hashes = phones.map { |ph| phone.validate_phone(ph) }
  binding.pry

  ############## ADDRESS BELOW ##############
  # address = CRMFormatter::Address.new
  #
  # address_hashes = 5.times.map do
  #   fk = Faker::Address
  #   adr_hsh = { street: fk.street_address.downcase, city: fk.city.downcase, state: fk.state.downcase, zip: fk.zip_code }
  # end
  #
  # formatted_address_hashes = address_hashes.map do |adr_hsh|
  #   address.format_full_address(adr_hsh)
  # end

  ############## WEB BELOW ##############
  # url_red_flags = %w(approv avis budget business collis eat enterprise facebook financ food google gourmet hertz hotel hyatt insur invest loan lube mobility motel motorola parts quick rent repair restaur rv ryder service softwar travel twitter webhost yellowpages yelp youtube)
  #
  # link_red_flags = %w(: .biz .co .edu .gov .jpg .net // afri anounc book business buy bye call cash cheap click collis cont distrib download drop event face feature feed financ find fleet form gas generat graphic hello home hospi hour hours http info insta inventory item join login mail mailto mobile movie museu music news none offer part phone policy priva pump rate regist review schedul school service shop site test ticket tire tv twitter watch www yelp youth)
  #
  # href_red_flags = %w(? .com .jpg @ * afri after anounc apply approved blog book business buy call care career cash charit cheap check click collis commerc cont contrib deal distrib download employ event face feature feed financ find fleet form gas generat golf here holiday hospi hour info insta inventory join later light login mail mobile movie museu music news none now oil part pay phone policy priva pump quick quote rate regist review saving schedul service shop sign site speci ticket tire today transla travel truck tv twitter watch youth)
  #
  # ext_red_flags = %w(au ca edu es gov in ru uk us)

  # args = { url_red_flags: url_red_flags,
  #         link_red_flags: link_red_flags,
  #         href_red_flags: href_red_flags,
  #         ext_red_flags: ext_red_flags
  #       }

  # web = CRMFormatter::Web.new(args)

  # urls = %w(http://thiel.com/chauncey_mobile http://thiel.com/ www.thiel.com thiel.com/chauncey_simonis thiel.com www.example.com/join-us-hello)
  #
  # validated_url_hashes = urls.map { |url| web.format_url(url) }
  # valid_urls = validated_url_hashes.map { |hsh| hsh[:valid_url] }.compact
  # extracted_link_hashes = urls.map { |url| web.extract_link(url) }
  # links = extracted_link_hashes.map { |hsh| hsh[:link] }.compact
  # validated_link_hashes = links.map { |link| web.remove_invalid_links(link) }
  #
  # hrefs = ["Hot Inventory", "Join Our Sale!", "Don't Wait till Later", "Apply Today!", "No Cash Down!"]

  # validated_href_hashes = hrefs.map { |href| web.remove_invalid_hrefs(href) }
  ############## WEB ABOVE ##############

end


# address = CRMFormatter::Address.new
# address.gh

# Start.new.one
# Start.new.state
# Start.new.self_state
# CRMFormatter::Address.new.state



# CRMFormatter.crm

# Start.new.start_greet
# Start.new.crm_greet

# CRMFormatter.crm_greet

# CRMFormatter.state
