# require 'crm_formatter'
require 'resolv'
require 'email_verifier'

## EmailGemRunner.new
class EmailGemRunner

  def initialize
    set_my_email
    binding.pry

    email_res = run_email_verifier

  end

  def set_my_email
    EmailVerifier.config do |config|
      binding.pry
      res = config.verifier_email = "4rlm@protonmail.ch"
      binding.pry
    end
  end

  def run_email_verifier
    email_hashes = grab_emails.map do |email|
      begin
        valid = EmailVerifier.check('4rlm@protonmail.ch')
      rescue StandardError => e
        valid = false
        binding.pry
      end

      hsh = { email: email, valid: valid }
      binding.pry
      hsh
    end

    binding.pry
    email_hashes

    # res = EmailVerifier.check('4rlm@protonmail.ch')
    # res = EmailVerifier.check('hottomale456876@protonmail.ch')
    # res2 = valid_email_host?('hottomale456876@protonmail.ch')
    # res2 = valid_email_host?('4rlm@protonmail.ch')
    # res1 = valid_email_host?('joe@oreilly.com')
  end


  def valid_email_host?(email)
    hostname = email[(email =~ /@/)+1..email.length]
    valid = true
    begin
      res = Resolv::DNS.new.getresource(hostname, Resolv::DNS::Resource::IN::MX)
      binding.pry
    rescue Resolv::ResolvError => e
      binding.pry
      valid = false
    end

    valid
  end


  def grab_emails
    %w[
      kimchi@coleautomotive.com
      apearce@coleautomotive.com
      ekendrick@coleautomotive.com
      credker@lynchauto.com
      john.brown@brucetitus.com
      michaelt@brucetitus.com
      jack.trimble@pomoco.net
      jhansel@hanselauto.com
      raylewis@onioncreekvw.com
      jdesantis@niello.com
      m@palmspringsnissan.com
      lucky@hebertstandc.com
      mikem@rudolphcars.com
      debbieb@rudolphcars.com
      fleslie@scanlonauto.com
      bradpavlik@baierl.com
    ]
  end

end
