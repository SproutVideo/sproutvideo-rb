module Sproutvideo
  class Response
    attr_accessor :status, :body, :raw_body
    
    def initialize(msg)
      self.status = msg.code
      self.raw_body = msg.to_s
      begin
        self.body = MultiJson.decode(self.raw_body, :symbolize_keys => true)
      rescue MultiJson::DecodeError
        self.body = msg.to_s
      end
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