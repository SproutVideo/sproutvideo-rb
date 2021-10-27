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
      begin
        resp = RestClient.post(
          "#{base_url}#{path}",
          body,
          {'SproutVideo-Api-Key' => api_key})
      rescue => e
        resp = e.response
      end
      Response.new(resp)
    end

    def self.upload(path, file_path, options = {}, field_name)
      resp = nil

      method = options.delete(:method) == :PUT ? :PUT : :POST

      File.open(file_path) do |file|

        body = { field_name => file }.merge(options.dup)

        begin
          resp = RestClient.send(
            method == :POST ? 'post' : 'put',
            "#{base_url}#{path}",
            body,
            {'SproutVideo-Api-Key' => api_key, :timeout => 18000})
        rescue => e
          puts e
          resp = e.response
        end
      end

      Response.new(resp)
    end

    def self.get(path, options = {})
      begin
        resp = RestClient.get(
          "#{base_url}#{path}",
          {'SproutVideo-Api-Key' => api_key, :params => options.dup})
      rescue => e
        resp = e.response
      end
      Response.new(resp)
    end

    def self.put(path, options = {})
      body = MultiJson.encode(options.dup)
      begin
        resp = RestClient.put(
          "#{base_url}#{path}",
          body,
          {'SproutVideo-Api-Key' => api_key})
      rescue => e
        resp = e.response
      end
      Response.new(resp)
    end

    def self.delete(path, options = {})
      begin
        resp = RestClient.delete(
          "#{base_url}#{path}",
          {'SproutVideo-Api-Key' => api_key, :params => options.dup})
      rescue => e
        resp = e.response
      end
      Response.new(resp)
    end
  end
end
