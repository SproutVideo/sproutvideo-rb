require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')
describe Sproutvideo do 
	
	it "should have the default base_url if not defined" do
		Sproutvideo.base_url.should == "https://api.sproutvideo.com/v1"
	end

	it "should accept a new api_key" do
		Sproutvideo.api_key = '1234'
		Sproutvideo.api_key.should == '1234'
	end

	it "should accept a new base_url" do
		Sproutvideo.base_url = 'https://api.sproutvideo.com/v2'
		Sproutvideo.base_url.should == 'https://api.sproutvideo.com/v2'
	end

	it "should grab the api_key from the ENV if it exists" do
		ENV['SPROUTVIDEO_API_KEY'] = '1234'
		Sproutvideo.api_key.should == '1234'
		ENV.delete('SPROUTVIDEO_API_KEY')
	end

	it "should take user-supplied api key over ENV-supplied key" do
    	Sproutvideo.api_key = "123"
		ENV['SPROUTVIDEO_API_KEY'] = '1234'
    	Sproutvideo.api_key.should == '123'
		ENV.delete('SPROUTVIDEO_API_KEY')
    end
end