require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')
describe Sproutvideo::Video do
	before(:each) do
		@api_key = 'abc123'
		Sproutvideo.api_key = @api_key
		Sproutvideo.base_url = 'https://api.sproutvideo.com/v1'
		@msg =  mock(:to_s => "{}", :code => 200)
	end

	describe "#create" do
		it "should POST the correct url and return a response" do
			#create temp file
			File.open("upload_test", "w+") do |f|
				f.syswrite("upload!")
			end

			file = File.open('upload_test')

			File.stub!(:open).with('upload_test').and_yield(file)

			RestClient.should_receive(:post).with(
				"#{Sproutvideo.base_url}/videos",
				{:source_video => file, :title => 'test title'},
				{'SproutVideo-Api-Key' => @api_key, :timeout => 18000}).and_return(@msg)


			Sproutvideo::Video.create('upload_test', {:title => 'test title'}).class.should == Sproutvideo::Response

			FileUtils.rm('upload_test')
		end
	end

	describe "#list" do
		before(:each) do
			@url = "#{Sproutvideo.base_url}/videos"
		end

		it "should GET the correct url and return a response" do
			
			RestClient.should_receive(:get).with(
				@url,
				{'SproutVideo-Api-Key' => @api_key, :params => {:page => 1, :per_page => 25}}).and_return(@msg)
			Sproutvideo::Video.list.class.should == Sproutvideo::Response
		end

		it "should merge params" do
			RestClient.should_receive(:get).with(
				@url,
				{'SproutVideo-Api-Key' => @api_key, :params => {:page => 1, :per_page => 25, :foo => 'bar'}}).and_return(@msg)
			Sproutvideo::Video.list(:foo => 'bar')
		end

		it "should use pagination params" do
			RestClient.should_receive(:get).with(
				@url,
				{'SproutVideo-Api-Key' => @api_key, :params => {:page => 2, :per_page => 5}}).and_return(@msg)
			Sproutvideo::Video.list(:page => 2, :per_page => 5)
		end

		it "should request videos for a tag if tag_id is passed in" do
			RestClient.should_receive(:get).with(
				@url,
				{'SproutVideo-Api-Key' => @api_key, :params => {:page => 1, :per_page => 25, :tag_id => 'asdf'}}).and_return(@msg)
			Sproutvideo::Video.list(:tag_id => 'asdf')
		end
	end

	describe "#details" do
		before(:each) do
			@video_id = 1
			@url = "#{Sproutvideo.base_url}/videos/#{@video_id}"
		end

		it "should get the correct url and return a response" do
			RestClient.should_receive(:get).with(
				@url,
				{'SproutVideo-Api-Key' => @api_key, :params => {}}).and_return(@msg)
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

			RestClient.should_receive(:put).with(
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
			RestClient.should_receive(:delete).with(
				@url,
				{'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
			Sproutvideo::Video.destroy(@video_id).class.should == Sproutvideo::Response
		end
	end

	describe "#signed_embed_code" do
		before(:each) do
			@video_id = 1
			@url = "#{Sproutvideo.base_url}/videos/#{@video_id}"
			@msg = mock(:code => 200, :to_s => {"id" => @video_id.to_s, "security_token" => "abc123"}.to_json)
			@digest = OpenSSL::Digest::Digest.new('sha1')
			OpenSSL::Digest::Digest.stub!(:new).and_return(@digest)
			time = Time.now
			Time.stub!(:now).and_return(time)
			@expires_time = time.to_i+300
			string_to_sign = "GET\nvideos.sproutvideo.com\n/embed/1/abc123\n&expires=#{@expires_time}"
			@signature = CGI::escape([OpenSSL::HMAC.digest(@digest, @api_key, string_to_sign)].pack("m").strip)
			RestClient.stub!(:get).and_return(@msg)
		end

		it "should get the video" do
			RestClient.should_receive(:get).with(
				@url,
				{'SproutVideo-Api-Key' => @api_key, :params => {}}).and_return(@msg)
			Sproutvideo::Video.signed_embed_code(@video_id)
		end
		
		it "should sign the embed code" do
			Sproutvideo::Video.signed_embed_code(@video_id).should == "http://videos.sproutvideo.com/embed/1/abc123?signature=#{@signature}&expires=#{@expires_time}"
		end

		it "should set the expires time if passed in" do
			expires_time = 1368127991
			string_to_sign = "GET\nvideos.sproutvideo.com\n/embed/1/abc123\n&expires=#{expires_time}"
			signature = CGI::escape([OpenSSL::HMAC.digest(@digest, @api_key, string_to_sign)].pack("m").strip)
			Sproutvideo::Video.signed_embed_code(@video_id, {}, 1368127991).should == "http://videos.sproutvideo.com/embed/1/abc123?signature=#{signature}&expires=#{expires_time}"
		end

		it "should use the protocol that's passed in" do
			Sproutvideo::Video.signed_embed_code(@video_id, {}, nil, 'https').should == "https://videos.sproutvideo.com/embed/1/abc123?signature=#{@signature}&expires=#{@expires_time}"
		end

		it "should sign other parameters too!" do
			string_to_sign = "GET\nvideos.sproutvideo.com\n/embed/1/abc123\n&expires=#{@expires_time}&type=hd"
			@signature = CGI::escape([OpenSSL::HMAC.digest(@digest, @api_key, string_to_sign)].pack("m").strip)
			Sproutvideo::Video.signed_embed_code(@video_id, {'type' => 'hd'}).should == "http://videos.sproutvideo.com/embed/1/abc123?signature=#{@signature}&expires=#{@expires_time}&type=hd"
		end
	end

	describe "#generate_signed_embed_code" do
		before(:each) do
			@video_id = 1
			@resp = mock(:body => {:id => @video_id.to_s, :security_token => "abc123"})
			@digest = OpenSSL::Digest::Digest.new('sha1')
			OpenSSL::Digest::Digest.stub!(:new).and_return(@digest)
			time = Time.now
			Time.stub!(:now).and_return(time)
			@expires_time = time.to_i+300
			string_to_sign = "GET\nvideos.sproutvideo.com\n/embed/1/abc123\n&expires=#{@expires_time}"
			@signature = CGI::escape([OpenSSL::HMAC.digest(@digest, @api_key, string_to_sign)].pack("m").strip)
		end

		it "should generate signed embed code" do
			Sproutvideo::Video.generate_signed_embed_code(@resp).should == "http://videos.sproutvideo.com/embed/1/abc123?signature=#{@signature}&expires=#{@expires_time}"
		end

		it "should set the expires time if passed in" do
			expires_time = 1368127991
			string_to_sign = "GET\nvideos.sproutvideo.com\n/embed/1/abc123\n&expires=#{expires_time}"
			signature = CGI::escape([OpenSSL::HMAC.digest(@digest, @api_key, string_to_sign)].pack("m").strip)
			Sproutvideo::Video.generate_signed_embed_code(@resp, {}, 1368127991).should == "http://videos.sproutvideo.com/embed/1/abc123?signature=#{signature}&expires=#{expires_time}"
		end

		it "should use the protocol that's passed in" do
			Sproutvideo::Video.generate_signed_embed_code(@resp, {}, nil, 'https').should == "https://videos.sproutvideo.com/embed/1/abc123?signature=#{@signature}&expires=#{@expires_time}"
		end

		it "should sign other parameters too!" do
			string_to_sign = "GET\nvideos.sproutvideo.com\n/embed/1/abc123\n&expires=#{@expires_time}&type=hd"
			@signature = CGI::escape([OpenSSL::HMAC.digest(@digest, @api_key, string_to_sign)].pack("m").strip)
			Sproutvideo::Video.generate_signed_embed_code(@resp, {'type' => 'hd'}).should == "http://videos.sproutvideo.com/embed/1/abc123?signature=#{@signature}&expires=#{@expires_time}&type=hd"
		end
	end

end