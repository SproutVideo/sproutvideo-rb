module Sproutvideo
  class Resource
    def self.api_key
      Sproutvideo.api_key
    end
    def self.base_url
      Sproutvideo.base_url
    end

    def self.post(path, options={})
      body = MultiJson.encode(options.dup)
      resp = HTTPClient.new.post(
        "#{base_url}#{path}",
        body,
        {'SproutVideo-Api-Key' => api_key})
      Response.new(resp)
    end

    def self.upload(path, file_path, options={})
      resp = nil
      File.open(file_path) do |file|
        body = {:source_video => file}.merge(options.dup)
        client = HTTPClient.new
        client.send_timeout = 18000
        resp = client.post(
          "#{base_url}#{path}",
          body,
          {'SproutVideo-Api-Key' => api_key})
      end
      
      Response.new(resp)
    end

    def self.get(path, options={})
      options = options.dup
      resp = HTTPClient.new.get(
        "#{base_url}#{path}",
        options,
        {'SproutVideo-Api-Key' => api_key})
      Response.new(resp)
    end

    def self.put(path, options={})
      body = MultiJson.encode(options.dup)
      resp = HTTPClient.new.put(
        "#{base_url}#{path}",
        body,
        {'SproutVideo-Api-Key' => api_key})
      Response.new(resp)
    end

    def self.delete(path, options={})
      resp = HTTPClient.new.delete(
        "#{base_url}#{path}",
        {},
        {'SproutVideo-Api-Key' => api_key})
      Response.new(resp)
    end
  end
end