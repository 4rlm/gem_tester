require 'url_verifier'

## VerifyGemRunner.new
class VerifyGemRunner

  def initialize
    # verified_url_hash = run_verify_url
    # verified_url_hashes = run_verify_urls
    binding.pry
  end


  def run_verify_url
    args = { timeout_limit: 30 }
    binding.pry

    verifier = UrlVerifier::RunCurler.new(args)
    binding.pry

    verified_url_hash = verifier.verify_url('blackwellford.com')
    binding.pry

    # strings_obj = ScrubDb::Strings.new(strings_criteria)
    # scrubbed_proper_strings = strings_obj.scrub_proper_strings(array_of_propers)
  end


  def run_verify_urls
    array_of_urls = %w[blackwellford.com/staff www.mccrea.subaru.com/inventory www.sofake.sofake https://www.century1chevy.com https://www.mccreasubaru.com]

    args = { timeout_limit: 30 }
    binding.pry

    verifier = UrlVerifier::RunCurler.new(args)
    binding.pry

    verified_url_hashes = verifier.verify_urls(array_of_urls)
    binding.pry


    # strings_obj = ScrubDb::Strings.new(strings_criteria)
    # scrubbed_proper_strings = strings_obj.scrub_proper_strings(array_of_propers)
  end

end
