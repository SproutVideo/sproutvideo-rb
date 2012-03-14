module Sproutvideo
	
	class << self
		attr_accessor :api_key, :base_url
	end

	self.api_key = nil
	self.base_url = 'https://api.sproutvideo.com/v1'

	def self.api_key
		@api_key || ENV['SPROUTVIDEO_API_KEY']
	end

	def self.base_url(env=nil)
		@base_url
	end
	
end