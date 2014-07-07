require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')
describe Sproutvideo::UploadToken do
  before(:each) do
    @api_key = 'abc123'
    Sproutvideo.api_key = @api_key
    Sproutvideo.base_url = 'https://api.sproutvideo.com/v1'
    @msg =  mock(:to_s => "{}", :code => 200)
  end

  describe "#create" do
    before(:each) do
      @url = "#{Sproutvideo.base_url}/upload_tokens"
    end

    it "should POST the correct url and return a response" do
      data = {:seconds_valid => 3600}
      RestClient.should_receive(:post).with(
        @url,
        MultiJson.encode(data),
        {'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
      Sproutvideo::UploadToken.create(data).class.should == Sproutvideo::Response
    end
  end
end
