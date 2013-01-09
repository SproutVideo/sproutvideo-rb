require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')
describe Sproutvideo::Analytics do
  before(:each) do
    @api_key = 'abc123'
    Sproutvideo.api_key = @api_key
    Sproutvideo.base_url = 'https://api.sproutvideo.com/v1'
    @msg =  mock(:to_s => "{}", :code => 200)
  end

  describe "#play_counts" do
    before(:each) do
      @url = "#{Sproutvideo.base_url}/stats/counts"
    end

    it "should GET the correct url for overall method call and return a response" do      
      RestClient.should_receive(:get).with(
        @url,
        {'SproutVideo-Api-Key' => @api_key, :params => {}}).and_return(@msg)
      Sproutvideo::Analytics.play_counts.class.should == Sproutvideo::Response
    end
    it "should GET the correct url for individual video method call and return a response" do
      RestClient.should_receive(:get).with(
        "#{@url}/abc123",
        {'SproutVideo-Api-Key' => @api_key, :params => {}}).and_return(@msg)
      Sproutvideo::Analytics.play_counts(:video_id => 'abc123').class.should == Sproutvideo::Response
    end
    it "should GET the correct url if dates are passed in" do
      RestClient.should_receive(:get).with(
        @url,
        {'SproutVideo-Api-Key' => @api_key, :params => {:start_date => '2012-12-31', :end_date => '2013-12-31'}}).and_return(@msg)
      Sproutvideo::Analytics.play_counts(:start_date => '2012-12-31', :end_date => '2013-12-31').class.should == Sproutvideo::Response
    end
  end

  describe "#domains" do
    before(:each) do
      @url = "#{Sproutvideo.base_url}/stats/domains"
    end

    it "should GET the correct url for overall method call and return a response" do      
      RestClient.should_receive(:get).with(
        @url,
        {'SproutVideo-Api-Key' => @api_key, :params => {}}).and_return(@msg)
      Sproutvideo::Analytics.domains.class.should == Sproutvideo::Response
    end
    it "should GET the correct url for individual video method call and return a response" do
      RestClient.should_receive(:get).with(
        "#{@url}/abc123",
        {'SproutVideo-Api-Key' => @api_key, :params => {}}).and_return(@msg)
      Sproutvideo::Analytics.domains(:video_id => 'abc123').class.should == Sproutvideo::Response
    end
    it "should GET the correct url if dates are passed in" do
      RestClient.should_receive(:get).with(
        @url,
        {'SproutVideo-Api-Key' => @api_key, :params => {:start_date => '2012-12-31', :end_date => '2013-12-31'}}).and_return(@msg)
      Sproutvideo::Analytics.domains(:start_date => '2012-12-31', :end_date => '2013-12-31').class.should == Sproutvideo::Response
    end
  end

  describe "#geo" do
    before(:each) do
      @url = "#{Sproutvideo.base_url}/stats/geo"
    end

    it "should GET the correct url for overall method call and return a response" do      
      RestClient.should_receive(:get).with(
        @url,
        {'SproutVideo-Api-Key' => @api_key, :params => {}}).and_return(@msg)
      Sproutvideo::Analytics.geo.class.should == Sproutvideo::Response
    end
    it "should GET the correct url for individual video method call and return a response" do
      RestClient.should_receive(:get).with(
        "#{@url}/abc123",
        {'SproutVideo-Api-Key' => @api_key, :params => {}}).and_return(@msg)
      Sproutvideo::Analytics.geo(:video_id => 'abc123').class.should == Sproutvideo::Response
    end
    it "should GET the correct url if dates are passed in" do
      RestClient.should_receive(:get).with(
        @url,
        {'SproutVideo-Api-Key' => @api_key, :params => {:start_date => '2012-12-31', :end_date => '2013-12-31'}}).and_return(@msg)
      Sproutvideo::Analytics.geo(:start_date => '2012-12-31', :end_date => '2013-12-31').class.should == Sproutvideo::Response
    end
    it "should GET the correct url if a country is passed in" do
      RestClient.should_receive(:get).with(
        "#{@url}/abc123",
        {'SproutVideo-Api-Key' => @api_key, :params => {:country => 'US', :start_date => '2012-12-31', :end_date => '2013-12-31'}}).and_return(@msg)
      Sproutvideo::Analytics.geo(:video_id => 'abc123', :country => 'US', :start_date => '2012-12-31', :end_date => '2013-12-31').class.should == Sproutvideo::Response
    end
  end

  describe "#video_types" do
    before(:each) do
      @url = "#{Sproutvideo.base_url}/stats/video_types"
    end

    it "should GET the correct url for overall method call and return a response" do      
      RestClient.should_receive(:get).with(
        @url,
        {'SproutVideo-Api-Key' => @api_key, :params => {}}).and_return(@msg)
      Sproutvideo::Analytics.video_types.class.should == Sproutvideo::Response
    end
    it "should GET the correct url for individual video method call and return a response" do
      RestClient.should_receive(:get).with(
        "#{@url}/abc123",
        {'SproutVideo-Api-Key' => @api_key, :params => {}}).and_return(@msg)
      Sproutvideo::Analytics.video_types(:video_id => 'abc123').class.should == Sproutvideo::Response
    end
    it "should GET the correct url if dates are passed in" do
      RestClient.should_receive(:get).with(
        @url,
        {'SproutVideo-Api-Key' => @api_key, :params => {:start_date => '2012-12-31', :end_date => '2013-12-31'}}).and_return(@msg)
      Sproutvideo::Analytics.video_types(:start_date => '2012-12-31', :end_date => '2013-12-31').class.should == Sproutvideo::Response
    end
  end

  describe "#playback_types" do
    before(:each) do
      @url = "#{Sproutvideo.base_url}/stats/playback_types"
    end

    it "should GET the correct url for overall method call and return a response" do      
      RestClient.should_receive(:get).with(
        @url,
        {'SproutVideo-Api-Key' => @api_key, :params => {}}).and_return(@msg)
      Sproutvideo::Analytics.playback_types.class.should == Sproutvideo::Response
    end
    it "should GET the correct url for individual video method call and return a response" do
      RestClient.should_receive(:get).with(
        "#{@url}/abc123",
        {'SproutVideo-Api-Key' => @api_key, :params => {}}).and_return(@msg)
      Sproutvideo::Analytics.playback_types(:video_id => 'abc123').class.should == Sproutvideo::Response
    end
    it "should GET the correct url if dates are passed in" do
      RestClient.should_receive(:get).with(
        @url,
        {'SproutVideo-Api-Key' => @api_key, :params => {:start_date => '2012-12-31', :end_date => '2013-12-31'}}).and_return(@msg)
      Sproutvideo::Analytics.playback_types(:start_date => '2012-12-31', :end_date => '2013-12-31').class.should == Sproutvideo::Response
    end
  end

  describe "#device_types" do
    before(:each) do
      @url = "#{Sproutvideo.base_url}/stats/device_types"
    end

    it "should GET the correct url for overall method call and return a response" do      
      RestClient.should_receive(:get).with(
        @url,
        {'SproutVideo-Api-Key' => @api_key, :params => {}}).and_return(@msg)
      Sproutvideo::Analytics.device_types.class.should == Sproutvideo::Response
    end
    it "should GET the correct url for individual video method call and return a response" do
      RestClient.should_receive(:get).with(
        "#{@url}/abc123",
        {'SproutVideo-Api-Key' => @api_key, :params => {}}).and_return(@msg)
      Sproutvideo::Analytics.device_types(:video_id => 'abc123').class.should == Sproutvideo::Response
    end
    it "should GET the correct url if dates are passed in" do
      RestClient.should_receive(:get).with(
        @url,
        {'SproutVideo-Api-Key' => @api_key, :params => {:start_date => '2012-12-31', :end_date => '2013-12-31'}}).and_return(@msg)
      Sproutvideo::Analytics.device_types(:start_date => '2012-12-31', :end_date => '2013-12-31').class.should == Sproutvideo::Response
    end
  end

  describe "#engagement" do
    before(:each) do
      @url = "#{Sproutvideo.base_url}/stats/engagement"
    end

    it "should GET the correct url for overall method call and return a response" do      
      RestClient.should_receive(:get).with(
        @url,
        {'SproutVideo-Api-Key' => @api_key, :params => {}}).and_return(@msg)
      Sproutvideo::Analytics.engagement.class.should == Sproutvideo::Response
    end
    it "should GET the correct url for individual video method call and return a response" do
      RestClient.should_receive(:get).with(
        "#{@url}/abc123",
        {'SproutVideo-Api-Key' => @api_key, :params => {}}).and_return(@msg)
      Sproutvideo::Analytics.engagement(:video_id => 'abc123').class.should == Sproutvideo::Response
    end
  end

  describe "#engagement_sessions" do
    before(:each) do
      @url = "#{Sproutvideo.base_url}/stats/engagement/abc123/sessions"
    end
    it "should GET the correct url for overall method call and return a response" do      
      RestClient.should_receive(:get).with(
        @url,
        {'SproutVideo-Api-Key' => @api_key, :params => {}}).and_return(@msg)
      Sproutvideo::Analytics.engagement_sessions('abc123').class.should == Sproutvideo::Response
    end

    it "should use pagination params" do
      RestClient.should_receive(:get).with(
        @url,
        {'SproutVideo-Api-Key' => @api_key, :params => {:page => 2, :per_page => 5}}).and_return(@msg)
      Sproutvideo::Analytics.engagement_sessions('abc123', :page => 2, :per_page => 5)
    end
  end


end