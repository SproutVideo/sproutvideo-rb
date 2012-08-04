require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')
describe Sproutvideo::AccessGrant do
	before(:each) do
		@api_key = 'abc123'
		Sproutvideo.api_key = @api_key
		Sproutvideo.base_url = 'https://api.sproutvideo.com/v1'
		@http_mock = mock()
		HTTPClient.stub!(:new).and_return(@http_mock)
		@msg =  mock(:body => "{}", :status => 200)
	end

	describe "#create" do
		before(:each) do
			@url = "#{Sproutvideo.base_url}/access_grants"
		end

		it "should POST the correct url and return a response" do
			data = {:email => 'test@example.com', :password => 'password'}
			@http_mock.should_receive(:post).with(
				@url,
				MultiJson.encode(data),
				{'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
			Sproutvideo::AccessGrant.create(data).class.should == Sproutvideo::Response
		end
	end

	describe "#list" do
		before(:each) do
			@url = "#{Sproutvideo.base_url}/access_grants"
		end

		it "should GET the correct url and return a response" do
			
			@http_mock.should_receive(:get).with(
				@url,
				{:page => 1, :per_page => 25},
				{'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
			Sproutvideo::AccessGrant.list.class.should == Sproutvideo::Response
		end

		it "should merge params" do
			@http_mock.should_receive(:get).with(
				@url,
				{:page => 1, :per_page => 25, :foo => 'bar'},
				{'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
			Sproutvideo::AccessGrant.list(:foo => 'bar')
		end

		it "should use pagination params" do
			@http_mock.should_receive(:get).with(
				@url,
				{:page => 2, :per_page => 5},
				{'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
			Sproutvideo::AccessGrant.list(:page => 2, :per_page => 5)
		end
	end

	describe "#details" do
		before(:each) do
			@access_grant_id = 1
			@url = "#{Sproutvideo.base_url}/access_grants/#{@access_grant_id}"
		end

		it "should get the correct url and return a response" do
			@http_mock.should_receive(:get).with(
				@url,
				{},
				{'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
			Sproutvideo::AccessGrant.details(@access_grant_id).class.should == Sproutvideo::Response
		end
	end

	describe "#update" do
		before(:each) do
			@access_grant_id = 1
			@url = "#{Sproutvideo.base_url}/access_grants/#{@access_grant_id}"
		end

		it "should PUT the correct url and return a response" do
			data = {:password => 'new password'}

			@http_mock.should_receive(:put).with(
				@url,
				MultiJson.encode(data),
				{'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
			Sproutvideo::AccessGrant.update(@access_grant_id, data).class.should == Sproutvideo::Response
		end

	end

	describe "#delete" do
		before(:each) do
			@access_grant_id = 1
			@url = "#{Sproutvideo.base_url}/access_grants/#{@access_grant_id}"
		end

		it "should DELETE the correct url and return a response" do
			@http_mock.should_receive(:delete).with(
				@url,
				{},
				{'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
			Sproutvideo::AccessGrant.destroy(@access_grant_id).class.should == Sproutvideo::Response
		end
	end

end