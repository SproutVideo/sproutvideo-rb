require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')
describe Sproutvideo::Video do
	before(:each) do
		@api_key = 'abc123'
		Sproutvideo.api_key = @api_key
		Sproutvideo.base_url = 'https://api.sproutvideo.com/v1'
		@http_mock = mock()
		HTTPClient.stub!(:new).and_return(@http_mock)
		@msg =  mock(:body => "{}", :status => 200)
	end

	describe "#create" do
		it "should POST the correct url and return a response" do
			#create temp file
			File.open("upload_test", "w+") do |f|
				f.syswrite("upload!")
			end

			file = File.open('upload_test')

			File.stub!(:open).with('upload_test').and_yield(file)

			@http_mock.should_receive(:post).with(
				"#{Sproutvideo.base_url}/videos",
				{:source_video => file, :title => 'test title'},
				{'SproutVideo-Api-Key' => @api_key}).and_return(@msg)


			Sproutvideo::Video.create('upload_test', {:title => 'test title'}).class.should == Sproutvideo::Response

			FileUtils.rm('upload_test')
		end
	end

	describe "#list" do
		before(:each) do
			@url = "#{Sproutvideo.base_url}/videos"
		end

		it "should GET the correct url and return a response" do
			
			@http_mock.should_receive(:get).with(
				@url,
				{:page => 1, :per_page => 25},
				{'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
			Sproutvideo::Video.list.class.should == Sproutvideo::Response
		end

		it "should merge params" do
			@http_mock.should_receive(:get).with(
				@url,
				{:page => 1, :per_page => 25, :foo => 'bar'},
				{'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
			Sproutvideo::Video.list(:foo => 'bar')
		end

		it "should use pagination params" do
			@http_mock.should_receive(:get).with(
				@url,
				{:page => 2, :per_page => 5},
				{'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
			Sproutvideo::Video.list(:page => 2, :per_page => 5)
		end

		it "should request videos for a tag if tag_id is passed in" do
			@http_mock.should_receive(:get).with(
				@url,
				{:page => 1, :per_page => 25, :tag_id => 'asdf'},
				{'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
			Sproutvideo::Video.list(:tag_id => 'asdf')
		end
	end

	describe "#details" do
		before(:each) do
			@video_id = 1
			@url = "#{Sproutvideo.base_url}/videos/#{@video_id}"
		end

		it "should get the correct url and return a response" do
			@http_mock.should_receive(:get).with(
				@url,
				{},
				{'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
			Sproutvideo::Video.details(@video_id).class.should == Sproutvideo::Response
		end
	end

	describe "#update" do
		before(:each) do
			@video_id = 1
			@url = "#{Sproutvideo.base_url}/videos/#{@video_id}"
		end

		it "should PUT the correct url and return a response" do
			data = {:title => 'new title'}

			@http_mock.should_receive(:put).with(
				@url,
				MultiJson.encode(data),
				{'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
			Sproutvideo::Video.update(@video_id, data).class.should == Sproutvideo::Response
		end

	end

	describe "#delete" do
		before(:each) do
			@video_id = 1
			@url = "#{Sproutvideo.base_url}/videos/#{@video_id}"
		end

		it "should DELETE the correct url and return a response" do
			@http_mock.should_receive(:delete).with(
				@url,
				{},
				{'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
			Sproutvideo::Video.destroy(@video_id).class.should == Sproutvideo::Response
		end
	end

end