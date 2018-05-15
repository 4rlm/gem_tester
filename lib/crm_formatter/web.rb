module CRMFormatter
  class Web

    def initialize(args={})
      @pos_urls = args.fetch(:pos_urls, [])
      @neg_urls = args.fetch(:neg_urls, [])
      @pos_links = args.fetch(:pos_links, [])
      @neg_links = args.fetch(:neg_links, [])
      @pos_hrefs = args.fetch(:pos_hrefs, [])
      @neg_hrefs = args.fetch(:neg_hrefs, [])
      @pos_exts = args.fetch(:pos_exts, [])
      @neg_exts = args.fetch(:neg_exts, [])
      @min_length = args.fetch(:min_length, 2)
      @max_length = args.fetch(:max_length, 100)
    end

    def get_banned_syms
      syms = ["!", "$", "%", "'", "(", ")", "*", "+", ",", "<", ">", "@", "[", "]", "^", "{", "}", "~"]
    end

    ##Call: StartCrm.run_webs
    def compare_criteria(hash, target, pn_key, include_or_equal)
      if pn_key.present?
        pn_list = instance_variable_get("@#{pn_key}")
        pn_list += get_banned_syms if %w(neg_urls neg_links neg_hrefs).include?(pn_key)

        if pn_list.present?
          if target.is_a?(::String)
            tars = target.split(', ')
          else
            tars = target
          end

          pn_matches = tars.map do |tar|
            if pn_list.present?
              if include_or_equal == 'include'
                pn_list.select { |el| el if target.include?(el) }.join(', ')
              elsif include_or_equal == 'equal'
                pn_list.select { |el| el if target == el }.join(', ')
              end
            end
          end

          pn_match = pn_matches&.uniq&.sort&.join(', ')
          if pn_match.present?
            if pn_key.include?('neg')
              hash[:neg] << "#{pn_key}: #{pn_match}"
            else
              hash[:pos] << "#{pn_key}: #{pn_match}"
            end
          end
        end

        hash
      end
    end


    ##Call: StartCrm.run_webs
    def format_url(url)
      prepared_result = prepare_for_uri(url)
      url_hash = prepared_result[:url_hash]
      url_hash = format_with_uri(url_hash, prepared_result[:url])
      url_hash
    end


    ##Call: StartCrm.run_webs
    def prepare_for_uri(url)
      url_hash = {url_path: url, formatted_url: nil, url_diff: false, neg: [], pos: [] }
      begin
        url = url&.split('|')&.first
        url = url&.split('\\')&.first
        url&.gsub!(/\P{ASCII}/, '')
        url = url&.downcase&.strip

        if url.length < @min_length
          url_hash[:neg] << "error: url_path < #{@min_length}"
        end

        2.times { remove_ww3(url) }
        url = remove_slashes(url)
        url&.strip!
        url = nil if url&.include?(' ')
        url = url[0..-2] if url[-1] == '/'

        url_hash = compare_criteria(url_hash, url, 'neg_urls', 'include') if url.present?
        url_hash = compare_criteria(url_hash, url, 'pos_urls', 'include') if url.present?
      rescue Exception => e
        url_hash[:neg] << "error: #{e}"
        binding.pry
      end
      prepared_result = { url_hash: url_hash, url: url }
    end


    ##Call: StartCrm.run_webs
    def format_with_uri(url_hash, url)
      begin
        uri = URI(url)
        host_parts = uri.host&.split(".")
        url_hash = compare_criteria(url_hash, host_parts, 'pos_exts', 'equal')
        url_hash = compare_criteria(url_hash, host_parts, 'neg_exts', 'equal')

        host = uri.host
        scheme = uri.scheme
        url = "#{scheme}://#{host}" if host.present? && scheme.present?
        url = "http://#{url}" if url[0..3] != "http"
        url = url.gsub("//", "//www.") if !url.include?("www.")

        url_hash[:formatted_url] = convert_to_scheme_host(url) if url.present?
        url_hash[:url_diff] = url_hash[:formatted_url] != url_hash[:url_path]
      rescue Exception => e
        url_hash[:error] = e
        binding.pry
        url_hash
      end

      url_hash
    end


    ###### Supporting Methods Below #######

    def extract_link(url_path)
      url_hash = format_url(url_path)
      url = url_hash[:formatted_url]
      link = url_path
      link_hsh = {url_path: url_path, url: url, link: nil }
      if url.present? && link.present? && link.length > @min_length
        url = strip_down_url(url)
        link = strip_down_url(link)
        link&.gsub!(url, '')
        link = link&.split('.net')&.last
        link = link&.split('.com')&.last
        link = link&.split('.org')&.last
        link = "/#{link.split("/").reject(&:empty?).join("/")}" if link.present?
        link_hsh[:link] = link if link.present? && link.length > @min_length
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
        flags << "below #{@min_length}" if link.length < @min_length
        flags << "over #{@max_length}" if link.length > @max_length
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
        flags << "over #{@max_length}" if href.length > @max_length
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
