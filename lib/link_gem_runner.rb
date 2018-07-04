require 'link_scraper'

## LinkGemRunner.new
class LinkGemRunner

  def initialize
    binding.pry
    # urls = %w[www.sample01.net.com sample02.com http://www.sample3.net www.sample04.net/contact_us http://sample05.net www.sample06.sofake www.sample07.com.sofake example08.not.real www.sample09.net/staff/management www.www.sample10.com]
    # formatted_urls = CrmFormatter.format_urls(urls)

    binding.pry
    scraped_links = run_link_scraper
    binding.pry
  end


  def run_link_scraper
    urls = %w[
      austinchevrolet.not.real
      smith_acura.com/staff
      abcrepair.ca
      hertzrentals.com/review
      londonhyundai.uk/fleet
      http://www.townbuick.net/staff
      http://youtube.com/download
      www.madridinfiniti.es/collision
      www.mitsubishideals.sofake
      www.dallassubaru.com.sofake
      www.quickeats.net/contact_us
      www.school.edu/teachers
      www.www.nissancars/inventory
      www.www.toyotatown.net/staff/management
      www.www.yellowpages.com/business
    ]

    binding.pry
    # scraper_obj = LinkScraper::Scrape.new(WebsCriteria.all_scrub_web_criteria)
    scraped_links = scraper_obj.scrub_urls(urls)
  end


end
