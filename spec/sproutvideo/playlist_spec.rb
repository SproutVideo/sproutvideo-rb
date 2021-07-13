require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')
describe Sproutvideo::Playlist do
	before(:each) do
		@api_key = 'abc123'
		Sproutvideo.api_key = @api_key
		Sproutvideo.base_url = 'https://api.sproutvideo.com/v1'
		@msg =  mock(:to_s => "{}", :code => 200)
	end

	describe "#create" do
		before(:each) do
			@url = "#{Sproutvideo.base_url}/playlists"
		end

		it "should POST the correct url and return a response" do
			data = {:name => 'new playlist'}
			RestClient.should_receive(:post).with(
				@url,
				MultiJson.encode(data),
				{'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
			Sproutvideo::Playlist.create(data).class.should == Sproutvideo::Response
		end
	end

	describe "#list" do
		before(:each) do
			@url = "#{Sproutvideo.base_url}/playlists"
		end

		it "should GET the correct url and return a response" do
			
			RestClient.should_receive(:get).with(
				@url,
				{'SproutVideo-Api-Key' => @api_key, :params => {:page => 1, :per_page => 25}}).and_return(@msg)
			Sproutvideo::Playlist.list.class.should == Sproutvideo::Response
		end

		it "should merge params" do
			RestClient.should_receive(:get).with(
				@url,
				{'SproutVideo-Api-Key' => @api_key, :params => {:page => 1, :per_page => 25, :foo => 'bar'}}).and_return(@msg)
			Sproutvideo::Playlist.list(:foo => 'bar')
		end

		it "should use pagination params" do
			RestClient.should_receive(:get).with(
				@url,
				{'SproutVideo-Api-Key' => @api_key, :params => {:page => 2, :per_page => 5}}).and_return(@msg)
			Sproutvideo::Playlist.list(:page => 2, :per_page => 5)
		end
	end

	describe "#details" do
		before(:each) do
			@playlist_id = 1
			@url = "#{Sproutvideo.base_url}/playlists/#{@playlist_id}"
		end

		it "should get the correct url and return a response" do
			RestClient.should_receive(:get).with(
				@url,
				{'SproutVideo-Api-Key' => @api_key, :params => {}}).and_return(@msg)
			Sproutvideo::Playlist.details(@playlist_id).class.should == Sproutvideo::Response
		end
	end

	describe "#update" do
		before(:each) do
			@playlist_id = 1
			@url = "#{Sproutvideo.base_url}/playlists/#{@playlist_id}"
		end

		it "should PUT the correct url and return a response" do
			data = {:name => 'new name'}

			RestClient.should_receive(:put).with(
				@url,
				MultiJson.encode(data),
				{'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
			Sproutvideo::Playlist.update(@playlist_id, data).class.should == Sproutvideo::Response
		end

	end

	describe "#delete" do
		before(:each) do
			@playlist_id = 1
			@url = "#{Sproutvideo.base_url}/playlists/#{@playlist_id}"
		end

		it "should DELETE the correct url and return a response" do
			RestClient.should_receive(:delete).with(
				@url,
				{'SproutVideo-Api-Key' => @api_key, :params =>  {}}).and_return(@msg)
			Sproutvideo::Playlist.destroy(@playlist_id).class.should == Sproutvideo::Response
		end
	end

end