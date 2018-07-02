class UTF8

  ##Rails C: UTF8.run
  def self.run
    # sanitized_data = Utf8Sanitizer.sanitize
    # puts sanitized_data.inspect

    orig_hashes = [{ :row_id=>"1", :url=>"stanleykaufman.com", :act_name=>"Stanley Chevrolet Kaufman\x99_\xCC", :street=>"825 E Fair St", :city=>"Kaufman", :state=>"TX", :zip=>"75142", :phone=>"(888) 457-4391\r\n" }]

    # sanitized_data = Utf8Sanitizer.sanitize(data: orig_hashes)
    sanitized_data = Utf8Sanitizer.sanitize(file_path: './lib/csv/seeds_dirty_1.csv')
    # sanitized_hashes = sanitized_data[:data][:valid_data]
    binding.pry
  end

end
