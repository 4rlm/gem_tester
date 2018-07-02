require 'url_verifier'

## VerifyGemRunner.new
class VerifyGemRunner

  def initialize
    # verified_url_hash = run_verify_url
    verified_url_hashes = run_verify_urls
    binding.pry
  end


  def run_verify_url
    args = { timeout_limit: 30 }
    verifier = UrlVerifier::RunCurler.new(args)
    verified_url_hash = verifier.verify_url('blackwellford.com')
  end


  def run_verify_urls
    array_of_urls = %w[blackwellford.com/staff www.mccrea.subaru.com/inventory www.sofake.sofake https://www.century1chevy.com https://www.mccreasubaru.com]

    args = { timeout_limit: 30 }
    verifier = UrlVerifier::RunCurler.new(args)
    verified_url_hashes = verifier.verify_urls(array_of_urls)
  end

end
