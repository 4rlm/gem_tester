require 'crm_formatter'

## CRMFGemRunner.new
class CRMFGemRunner

  def initialize
    # urls = %w[www.sample01.net.com sample02.com http://www.sample3.net www.sample04.net/contact_us http://sample05.net www.sample06.sofake www.sample07.com.sofake example08.not.real www.sample09.net/staff/management www.www.sample10.com]
    # formatted_urls = CrmFormatter.format_urls(urls)

    binding.pry

    array_of_propers = [
      'the gmc and bmw-world of AUSTIN tx',
      '123 Car-world Kia OF CHICAGO IL',
      'Main Street Ford in DALLAS tX',
      'broad st fiat of houston',
      'hot-deal auto insurance',
      'BUDGET - AUTOMOTORES ZONA & FRANCA, INC',
      'DOWNTOWN CAR REPAIR, INC',
      'Young Gmc Trucks',
      'TEXAS TRAVEL, CO',
      'youmans Chevrolet',
      'quick auto approval, inc',
      'yazell chevy',
      'quick cAr LUBE',
      'yAtEs AuTo maLL',
      'YADKIN VALLEY COLLISION CO',
      'XIT FORD INC'
    ]

    binding.pry
    formatted_proper_hashes = CrmFormatter.format_propers(array_of_propers)
    binding.pry

  end

end
