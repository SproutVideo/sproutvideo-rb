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
      if options.include?(:live_stream)
        options.delete(:live_stream)
        url = "/stats/live_streams/engagement"
      else
        url = build_path("/stats/engagement", options)
      end
      get(url, options)
    end

    def self.engagement_sessions(options={})
      url = "/stats/engagement/sessions"
      if options.include?(:live_stream)
        options.delete(:live_stream)
        url = "/stats/live_streams/engagement/sessions"
      elsif options.include?(:video_id)
        url = "/stats/engagement/#{options[:video_id]}/sessions"
        options.delete(:video_id)
      elsif options.include?(:live_stream_id)
        url = "/stats/live_streams/#{options[:live_stream_id]}/engagement/sessions"
        options.delete(:live_stream_id)
      end
      get(url, options)
    end

    def self.popular_videos(options={})
      get("/stats/popular_videos", options)
    end

    def self.live_stream_overview(live_stream_id, options={})
      get("/stats/live_streams/#{live_stream_id}/overview", options)
    end

    private

    def self.build_path(path, options)
      if options.include?(:video_id)
        video_id = options.delete(:video_id)
        path += "/#{video_id}"
      end
      if options.include?(:live_stream_id)
        video_id = options.delete(:live_stream_id)
        resource = path.split('/').last
        path = "/stats/live_streams/#{video_id}/#{resource}"
      end
      path
    end
  end
end
