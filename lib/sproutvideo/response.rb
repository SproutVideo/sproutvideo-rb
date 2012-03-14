module Sproutvideo
  class Response
    attr_accessor :status, :body, :raw_body
    
    def initialize(msg)
      self.status = msg.status
      self.raw_body = msg.body
      self.body = MultiJson.decode(self.raw_body, :symbolize_keys => true)
    end 

    def success?
      status.to_i > 199 && status.to_i < 300
    end

    def errors
      if body.is_a?(Hash)
        Array(body[:error]).compact
      else
        []
      end
    end
  end
end