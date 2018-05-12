class Article < ApplicationRecord
  # before_save :full_address, :track_act_change
  before_save :format_data

  # def greeter
  #   # CRMFormatter.hi 'english'
  #   # formatter = CRMFormatter.new
  #   binding.pry
  #   CRMFormatter.hi('english')
  #   binding.pry
  # end

  def format_data
    self.full_address = CRMFormatter.hi('english')
    binding.pry
  end


  # def full_address
  #   self.full_address = [street, city, state, zip].compact.join(', ')
  # end

end


# app.get '/articles/1'
# > app.get '/posts/1'
# > response = app.response
