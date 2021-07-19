module Sproutvideo
  class CallToAction < Resource
    def self.create(options = {})
      post(build_url(options), options)
    end
    
    def self.list(options = {})
      url = build_url(options)
      params = {
        :page => options.delete(:page) || 1,
        :per_page => options.delete(:per_page) || 25
      }
      params = params.merge(options)
      get(url, params)
    end

    def self.details(options = {})
      get("#{build_url(options)}/#{options[:id]}", options)
    end

    def self.update(options = {})
      put("#{build_url(options)}/#{options[:id]}", options)
    end

    def self.destroy(options = {})
      delete("#{build_url(options)}/#{options[:id]}", options)
    end
    
    private

    def self.build_url(options)
      if !options.include?(:video_id)
        STDERR.puts "The video_id option is required for this endpoint."
      end
      video_id = options.delete(:video_id)
      "/videos/#{video_id}/calls_to_action"
    end
  end
end