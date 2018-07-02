require 'crm_formatter'

## NokoGemRunner.new
class NokoGemRunner

  def initialize
    noko_page_hash = run_mechanizer
  end

  def run_mechanizer
    binding.pry
    noko = Mechanizer::Noko.new
    args = {url: 'https://www.wikipedia.org', timeout: 30}
    noko_hash = noko.scrape(args)

    err_msg = noko_hash[:err_msg]
    page = noko_hash[:page]
    texts_and_hrefs = noko_hash[:texts_and_hrefs]

    other_projects = page.css('.other-project')&.text
    other_projects = other_projects.split("\n").reject(&:blank?)
    binding.pry
  end

end
