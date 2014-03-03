class Client < ActiveRecord::Base

  before_create :create_api_key	
  attr_accessible :api_key, :last_accessed

  def accessed!
  	self.last_accessed = DateTime.now
  	save
  end

  protected

  def create_api_key
  	self.api_key = loop do
      api_key = SecureRandom.urlsafe_base64(nil, false)
      break api_key unless Client.exists?(api_key: api_key)
  	end
  end
end
