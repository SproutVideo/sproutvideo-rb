require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')
describe Sproutvideo::Tag do
	before(:each) do
		@api_key = 'abc123'
		Sproutvideo.api_key = @api_key
		Sproutvideo.base_url = 'https://api.sproutvideo.com/v1'
		@msg =  mock(:to_s => "{}", :code => 200)
	end

  describe "#details" do
    it "should get the correct url and return a response" do
			RestClient.should_receive(:get).with(
				"#{Sproutvideo.base_url}/account",
				{'SproutVideo-Api-Key' => @api_key, :params => {}}).and_return(@msg)
			Sproutvideo::Account.details.class.should == Sproutvideo::Response
		end
  end

  describe "#update" do
    it "should PUT the correct url and return a response" do
			data = {:download_sd => true}

			RestClient.should_receive(:put).with(
				"#{Sproutvideo.base_url}/account",
				MultiJson.encode(data),
				{'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
			Sproutvideo::Account.update(data).class.should == Sproutvideo::Response
		end
  end

end
