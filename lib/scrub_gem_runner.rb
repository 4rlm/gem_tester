require 'scrub_db'

## ScrubGemRunner.new
class ScrubGemRunner

  def initialize
    scrubbed_proper_strings = run_scrub_proper_strings
    binding.pry
  end

  def run_scrub_proper_strings
    strings_criteria = {
      pos_criteria: WebsCriteria.seed_pos_urls,
      neg_criteria: WebsCriteria.seed_neg_urls
    }

    array_of_propers = [
      'quick auto approval, inc',
      'the gmc and bmw-world of AUSTIN tx',
      'DOWNTOWN CAR REPAIR, INC',
      'TEXAS TRAVEL, CO',
      '123 Car-world Kia OF CHICAGO IL',
      'Main Street Ford in DALLAS tX',
      'broad st fiat of houston',
      'hot-deal auto insurance',
      'BUDGET - AUTOMOTORES ZONA & FRANCA, INC',
      'Young Gmc Trucks',
      'youmans Chevrolet',
      'yazell chevy',
      'quick cAr LUBE',
      'yAtEs AuTo maLL',
      'YADKIN VALLEY COLLISION CO',
      'XIT FORD INC'
    ]

    strings_obj = ScrubDb::Strings.new(strings_criteria)
    scrubbed_proper_strings = strings_obj.scrub_proper_strings(array_of_propers)
  end

end
