module Sproutvideo
  class Analytics < Resource
    def self.play_counts(options={})
      url = build_path("/stats/counts", options)
      get(url, options)
    end

    def self.domains(options={})
      url = build_path("/stats/domains", options)
      get(url, options)
    end

    def self.geo(options={})
      url = build_path("/stats/geo", options)
      get(url, options)
    end

    def self.video_types(options={})
      url = build_path("/stats/video_types", options)
      get(url, options)
    end

    def self.playback_types(options={})
      url = build_path("/stats/playback_types", options)
      get(url, options)
    end

    def self.device_types(options={})
      url = build_path("/stats/device_types", options)
      get(url, options)
    end

    def self.engagement(options={})
      url = build_path("/stats/engagement", options)
      get(url, options)
    end

    def self.engagement_sessions(video_id, options={})
      url = "/stats/engagement/#{video_id}/sessions"
      get(url, options)
    end

    private

    def self.build_path(path, options)
      if options.include?(:video_id)
        video_id = options.delete(:video_id)
        path += "/#{video_id}"
      end
      path
    end
  end
end
