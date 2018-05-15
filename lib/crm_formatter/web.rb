module CRMFormatter
  class Web

    # def initialize(args={})
    #   @url_oa = args.fetch(:url_oa, [])
    #   @link_oa = args.fetch(:link_oa, [])
    #   @href_oa = args.fetch(:href_oa, [])
    #   @extension_oa = args.fetch(:extension_oa, [])
    #   @length_min = args.fetch(:length_min, 2)
    #   @length_max = args.fetch(:length_max, 100)
    # end


    def initialize(args={})
      @pos_urls = args.fetch(:pos_urls, ['www', 'com', 'dragon'])
      @neg_urls = args.fetch(:neg_urls, ['http', 'grossinger', 'dragon'])

      @pos_links = args.fetch(:pos_links, [])
      @neg_links = args.fetch(:neg_links, [])

      @pos_hrefs = args.fetch(:pos_hrefs, [])
      @neg_hrefs = args.fetch(:neg_hrefs, [])

      @pos_exts = args.fetch(:pos_exts, [])
      @neg_exts = args.fetch(:neg_exts, [])

      @length_min = args.fetch(:length_min, 2)
      @length_max = args.fetch(:length_max, 100)
    end

    def get_banned_syms
      syms = ["!", "$", "%", "'", "(", ")", "*", "+", ",", "<", ">", "@", "[", "]", "^", "{", "}", "~"]
    end

    def get_key(hash, pos_neg)
      keys = hash.map { |k,v| k.to_s if !v.present? }.compact
      pos_key = keys.select { |k| k if k.include?(pos_neg) }.compact.join('')
    end

    def match_pn_list(target, pn_key)
      if pn_key.present?
        pn_list = instance_variable_get("@#{pn_key}")
        pn_list += get_banned_syms if pn_key.include?('neg')
        pn_match = pn_list.select { |el| el if target.include?(el) }.join(', ')
        binding.pry if pn_key.include?('neg')
        return pn_match
      end
    end


    def update_hash_pn(hash, target, pn_key)
      pn_match = match_pn_list(target, pn_key) if pn_key.present?
      hash[pn_key.to_sym] = pn_match
      return hash
    end


    ##Call: StartCrm.run_webs
    def check_pos_neg(hash, target)
      # target = "http://www.grossinger.com/"
      # url = target
      # hash = {url_path: "http://www.grossinger.com/", formatted_url: nil, url_edit: false, pos_urls: nil, neg_urls: nil }

      pos_key = get_key(hash, 'pos')
      hash = update_hash_pn(hash, target, pos_key) if pos_key.present?

      neg_key = get_key(hash, 'neg')
      hash = update_hash_pn(hash, target, neg_key) if neg_key.present?
      binding.pry

      return hash
    end


    def format_url(url)
      url_hsh = {url_path: url, formatted_url: nil, url_edit: false, neg_urls: nil, pos_urls: nil }
      if url.present?
        begin
          url = url&.split('|')&.first
          url = url&.split('\\')&.first
          url&.gsub!(/\P{ASCII}/, '')
          url = url&.downcase&.strip
          return url_hsh if url&.length < @length_min

          2.times { remove_ww3(url) } if url.present?
          url = remove_slashes(url) if url.present?
          url&.strip!

          return url_hsh if !url.present? || url&.include?(' ')
          url = url[0..-2] if url[-1] == '/'

          binding.pry
          url_hsh = check_pos_neg(url_hsh, url)
          binding.pry

          return url_hsh if get_banned_syms.any? {|symb| url&.include?(symb) }

          uri = URI(url)
          if uri.present?
            host_parts = uri.host&.split(".")

            if @neg_exts.any?
              bad_host_sts = host_parts&.map { |part| TRUE if @neg_exts.any? {|ext| part == ext } }&.compact&.first
              return url_hsh if bad_host_sts
            end

            host = uri.host
            scheme = uri.scheme
            url = "#{scheme}://#{host}" if host.present? && scheme.present?
            url = "http://#{url}" if url[0..3] != "http"
            url = url.gsub("//", "//www.") if !url.include?("www.")

            return url_hsh if @neg_urls.any? { |bad_text| url&.include?(bad_text) }

            url_hsh[:formatted_url] = convert_to_scheme_host(url) if url.present?
            url_hsh[:url_edit] = url_hsh[:formatted_url] != url_hsh[:url_path]
          end
        rescue
          return url_hsh
        end
      end
      url_hsh
    end


    ###### Supporting Methods Below #######

    def extract_link(url_path)
      url_hsh = format_url(url_path)
      url = url_hsh[:formatted_url]
      link = url_path
      link_hsh = {url_path: url_path, url: url, link: nil }
      if url.present? && link.present? && link.length > @length_min
        url = strip_down_url(url)
        link = strip_down_url(link)
        link&.gsub!(url, '')
        link = link&.split('.net')&.last
        link = link&.split('.com')&.last
        link = link&.split('.org')&.last
        link = "/#{link.split("/").reject(&:empty?).join("/")}" if link.present?
        link_hsh[:link] = link if link.present? && link.length > @length_min
      end
      link_hsh
    end


    def strip_down_url(url)
      if url.present?
        url = url.downcase.strip
        url = url.gsub('www.', '')
        url = url.split('://')
        url = url[-1]
        return url
      end
    end


    def remove_invalid_links(link)
      link_hsh = {link: link, valid_link: nil, flags: nil }
      if link.present?
        @neg_links += get_symbs
        flags = @neg_links.select { |red| link&.include?(red) }
        flags << "below #{@length_min}" if link.length < @length_min
        flags << "over #{@length_max}" if link.length > @length_max
        flags = flags.flatten.compact
        flags.any? ? valid_link = nil : valid_link = link
        link_hsh[:valid_link] = valid_link
        link_hsh[:flags] = flags.join(', ')
      end
      link_hsh
    end


    def remove_invalid_hrefs(href)
      href_hsh = {href: href, valid_href: nil, flags: nil }
      if href.present?
        @neg_hrefs += get_symbs
        href = href.split('|').join(' ')
        href = href.split('/').join(' ')
        href&.gsub!("(", ' ')
        href&.gsub!(")", ' ')
        href&.gsub!("[", ' ')
        href&.gsub!("]", ' ')
        href&.gsub!(",", ' ')
        href&.gsub!("'", ' ')

        flags = []
        flags << "over #{@length_max}" if href.length > @length_max
        invalid_text = Regexp.new(/[0-9]/)
        flags << invalid_text&.match(href)
        href = href&.downcase
        href = href&.strip

        flags << @neg_hrefs.select { |red| href&.include?(red) }
        flags = flags.flatten.compact.uniq
        href_hsh[:valid_href] = href unless flags.any?
        href_hsh[:flags] = flags.join(', ')
      end
      href_hsh
    end


    def convert_to_scheme_host(url)
      if url.present?
        uri = URI(url)
        scheme = uri&.scheme
        host = uri&.host
        url = "#{scheme}://#{host}" if (scheme.present? && host.present?)
        return url
      end
    end


    #CALL: Formatter.new.remove_ww3(url)
    def remove_ww3(url)
      if url.present?
        url.split('.').map { |part| url.gsub!(part,'www') if part.scan(/ww[0-9]/).any? }
        url&.gsub!("www.www", "www")
      end
    end


    # For rare cases w/ urls with mistaken double slash twice.
    def remove_slashes(url)
      if url.present? && url.include?('//')
        parts = url.split('//')
        return parts[0..1].join if parts.length > 2
      end
      return url
    end


  end
end
