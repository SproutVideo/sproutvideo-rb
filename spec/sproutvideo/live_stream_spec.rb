require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')
describe Sproutvideo::LiveStream do
  before(:each) do
    @api_key = 'abc123'
    Sproutvideo.api_key = @api_key
    Sproutvideo.base_url = 'https://api.sproutvideo.com/v1'
    @msg =  mock(:to_s => "{}", :code => 200)
  end

  describe "#create" do
    it "should POST the correct url and return a response" do
      data = { title: 'newww live stream'}
      RestClient.should_receive(:post).with(
        "#{Sproutvideo.base_url}/live_streams",
        MultiJson.encode(data),
        {'SproutVideo-Api-Key' => @api_key}).and_return(@msg)

      Sproutvideo::LiveStream.create(data).class.should == Sproutvideo::Response
    end

    it "should POST the correct url with file and return a response" do
      File.open("upload_test", "w+") do |f|
        f.syswrite("upload!")
      end

      file = File.open('upload_test')

      File.stub!(:open).with('upload_test').and_yield(file)

      RestClient.should_receive(:post).with(
        "#{Sproutvideo.base_url}/live_streams",
        {:custom_poster_frame => file, :title => 'test title'},
        {'SproutVideo-Api-Key' => @api_key, :timeout => 18000}).and_return(@msg)
      Sproutvideo::LiveStream.create({:title => 'test title', :custom_poster_frame => 'upload_test' }).class.should == Sproutvideo::Response

      FileUtils.rm('upload_test')
    end
  end

  describe "#list" do
    before(:each) do
      @url = "#{Sproutvideo.base_url}/live_streams"
    end

    it "should GET the correct url and return a response" do

      RestClient.should_receive(:get).with(
        @url,
        {'SproutVideo-Api-Key' => @api_key, :params => {:page => 1, :per_page => 25}}).and_return(@msg)
      Sproutvideo::LiveStream.list.class.should == Sproutvideo::Response
    end

    it "should merge params" do
      RestClient.should_receive(:get).with(
        @url,
        {'SproutVideo-Api-Key' => @api_key, :params => {:page => 1, :per_page => 25, :foo => 'bar'}}).and_return(@msg)
      Sproutvideo::LiveStream.list(:foo => 'bar')
    end

    it "should use pagination params" do
      RestClient.should_receive(:get).with(
        @url,
        {'SproutVideo-Api-Key' => @api_key, :params => {:page => 2, :per_page => 5}}).and_return(@msg)
      Sproutvideo::LiveStream.list(:page => 2, :per_page => 5)
    end

    it "should request live_streams for a tag if tag_id is passed in" do
      RestClient.should_receive(:get).with(
        @url,
        {'SproutVideo-Api-Key' => @api_key, :params => {:page => 1, :per_page => 25, :tag_id => 'asdf'}}).and_return(@msg)
      Sproutvideo::LiveStream.list(:tag_id => 'asdf')
    end
  end

  describe "#details" do
    before(:each) do
      @live_stream_id = 1
      @url = "#{Sproutvideo.base_url}/live_streams/#{@live_stream_id}"
    end

    it "should get the correct url and return a response" do
      RestClient.should_receive(:get).with(
        @url,
        {'SproutVideo-Api-Key' => @api_key, :params => {}}).and_return(@msg)
      Sproutvideo::LiveStream.details(@live_stream_id).class.should == Sproutvideo::Response
    end
  end

  describe "#update" do
    before(:each) do
      @live_stream_id = 1
      @url = "#{Sproutvideo.base_url}/live_streams/#{@live_stream_id}"
    end

    it "should PUT the correct url and return a response" do
      data = {:title => 'new title'}

      RestClient.should_receive(:put).with(
        @url,
        MultiJson.encode(data),
        {'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
      Sproutvideo::LiveStream.update(@live_stream_id, data).class.should == Sproutvideo::Response
    end

    it "should PUT the correct url and return a response" do
      File.open("upload_test2", "w+") do |f|
        f.syswrite("upload!")
      end

      file = File.open('upload_test2')

      File.stub!(:open).with('upload_test2').and_yield(file)

      RestClient.should_receive(:put).with(
        "#{Sproutvideo.base_url}/live_streams/#{@live_stream_id}",
        {:custom_poster_frame => file, :title => 'test title'},
        {'SproutVideo-Api-Key' => @api_key, :timeout => 18000}).and_return(@msg)
      Sproutvideo::LiveStream.update(@live_stream_id, {:title => 'test title', :custom_poster_frame => 'upload_test2' }).class.should == Sproutvideo::Response

      FileUtils.rm('upload_test2')
    end
  end

  describe "#delete" do
    before(:each) do
      @live_stream_id = 1
      @url = "#{Sproutvideo.base_url}/live_streams/#{@live_stream_id}"
    end

    it "should DELETE the correct url and return a response" do
      RestClient.should_receive(:delete).with(
        @url,
        {'SproutVideo-Api-Key' => @api_key, :params =>  {}}).and_return(@msg)
      Sproutvideo::LiveStream.destroy(@live_stream_id).class.should == Sproutvideo::Response
    end
  end

  describe "#end_stream" do
    before(:each) do
      @live_stream_id = 1
      @url = "#{Sproutvideo.base_url}/live_streams/#{@live_stream_id}/end_stream"
    end

    it "should PUT the correct url and return a response" do
      RestClient.should_receive(:put).with(
        @url,
        "{}",
        {'SproutVideo-Api-Key' => @api_key}).and_return(@msg)
      Sproutvideo::LiveStream.end_stream(@live_stream_id).class.should == Sproutvideo::Response
    end
  end
end
