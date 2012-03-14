require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')
describe Sproutvideo::Response do 
	describe "#success?" do
		it "should return true when status is between 200 and 299" do
			msg = mock(:status => 200, :body => "{}")
			Sproutvideo::Response.new(msg).success?.should == true
			msg.stub!(:status).and_return(299)
			Sproutvideo::Response.new(msg).success?.should == true
			msg.stub!(:status).and_return(250)
			Sproutvideo::Response.new(msg).success?.should == true
		end

		it "should return false when status is less than 200 or greater than 299" do
			msg = mock(:status => 300, :body => "{}")
			Sproutvideo::Response.new(msg).success?.should == false
			msg.stub!(:status => 199)
			Sproutvideo::Response.new(msg).success?.should == false
		end
	end
	
	describe "#errors" do
		it "should return an empty array when the result has no errors" do
			msg = mock(:status => 200, :body => "{}")
			Sproutvideo::Response.new(msg).errors.should == []
		end

		it "should return a compacted array of errors if the body has errors" do
			msg = mock(:status => 200, :body => '{"error":"Unauthorized"}')
			Sproutvideo::Response.new(msg).errors.should == ['Unauthorized']
		end
	end

	describe "#body" do
		it "should decode the body" do
			body = {:foo => 'bar'}
			msg = mock(:status => 200, :body => MultiJson.encode(body))
			Sproutvideo::Response.new(msg).body.should == body
		end
	end


end