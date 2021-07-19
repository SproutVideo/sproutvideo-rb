require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')
describe Sproutvideo::Subtitle do
	before(:each) do
		@api_key = 'abc123'
    @video_id = 1
		Sproutvideo.api_key = @api_key
		Sproutvideo.base_url = 'https://api.sproutvideo.com/v1'
		@msg =  mock(:to_s => "{}", :code => 200)
	end

	describe "#create" do
		it "should POST the correct url and return a response" do
			request_data = { :language => 'en', :content => 'WEBVTT FILE...' }
			RestClient.should_receive(:post).with(
				"#{Sproutvideo.base_url}/videos/#{@video_id}/subtitles",
				MultiJson.encode(request_data),
				{'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
      data = request_data
      data[:video_id] = @video_id
			Sproutvideo::Subtitle.create(data).class.should == Sproutvideo::Response
		end
	end

	describe "#list" do
		before(:each) do
			@url = "#{Sproutvideo.base_url}/videos/#{@video_id}/subtitles"
		end

		it "should GET the correct url and return a response" do
			
			RestClient.should_receive(:get).with(
				@url,
				{'SproutVideo-Api-Key' => @api_key, :params => {:page => 1, :per_page => 25}}).and_return(@msg)
			Sproutvideo::Subtitle.list(video_id: @video_id).class.should == Sproutvideo::Response
		end

		it "should merge params" do
			RestClient.should_receive(:get).with(
				@url,
				{'SproutVideo-Api-Key' => @api_key, :params => {:page => 1, :per_page => 25, :foo => 'bar'}}).and_return(@msg)
			Sproutvideo::Subtitle.list(video_id: @video_id, :foo => 'bar')
		end

		it "should use pagination params" do
			RestClient.should_receive(:get).with(
				@url,
				{'SproutVideo-Api-Key' => @api_key, :params => {:page => 2, :per_page => 5}}).and_return(@msg)
			Sproutvideo::Subtitle.list(video_id: @video_id, :page => 2, :per_page => 5)
		end
	end

	describe "#details" do
		before(:each) do
			@subtitle_id = '12'
			@url = "#{Sproutvideo.base_url}/videos/#{@video_id}/subtitles/#{@subtitle_id}"
		end

		it "should get the correct url and return a response" do
			RestClient.should_receive(:get).with(
				@url,
				{'SproutVideo-Api-Key' => @api_key, :params => { id: @subtitle_id }}).and_return(@msg)
			Sproutvideo::Subtitle.details(id: @subtitle_id, video_id: @video_id).class.should == Sproutvideo::Response
		end
	end

	describe "#update" do
		before(:each) do
			@subtitle_id = '12'
			@url = "#{Sproutvideo.base_url}/videos/#{@video_id}/subtitles/#{@subtitle_id}"
		end

		it "should PUT the correct url and return a response" do
			request_data = {:language => 'de', id: @subtitle_id}

			RestClient.should_receive(:put).with(
				@url,
				MultiJson.encode(request_data),
				{'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
      data = request_data
      data[:video_id] = @video_id
			Sproutvideo::Subtitle.update(data).class.should == Sproutvideo::Response
		end
	end

	describe "#delete" do
		before(:each) do
			@subtitle_id = '12'
			@url = "#{Sproutvideo.base_url}/videos/#{@video_id}/subtitles/#{@subtitle_id}"
		end

		it "should DELETE the correct url and return a response" do
			RestClient.should_receive(:delete).with(
				@url,
				{'SproutVideo-Api-Key' => @api_key, :params => { id: @subtitle_id }}).and_return(@msg)
			Sproutvideo::Subtitle.destroy(id: @subtitle_id, video_id: @video_id).class.should == Sproutvideo::Response
    end
	end
end