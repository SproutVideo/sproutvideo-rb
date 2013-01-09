module Sproutvideo
  class Analytics < Resource
    
    def self.play_counts(options={})
      url = "/stats/counts"
      if options.include?(:video_id)
        video_id = options.delete(:video_id)
        url += "/#{video_id}"
      end
      get(url, options)
    end

    def self.domains(options={})
      url = "/stats/domains"
      if options.include?(:video_id)
        video_id = options.delete(:video_id)
        url += "/#{video_id}"
      end
      get(url, options)
    end

    def self.geo(options={})
      url = "/stats/geo"
      if options.include?(:video_id)
        video_id = options.delete(:video_id)
        url += "/#{video_id}"
      end
      get(url, options)
    end

    def self.video_types(options={})
      url = "/stats/video_types"
      if options.include?(:video_id)
        video_id = options.delete(:video_id)
        url += "/#{video_id}"
      end
      get(url, options)
    end

    def self.playback_types(options={})
      url = "/stats/playback_types"
      if options.include?(:video_id)
        video_id = options.delete(:video_id)
        url += "/#{video_id}"
      end
      get(url, options)
    end

    def self.device_types(options={})
      url = "/stats/device_types"
      if options.include?(:video_id)
        video_id = options.delete(:video_id)
        url += "/#{video_id}"
      end
      get(url, options)
    end

    def self.engagement(options={})
      url = "/stats/engagement"
      if options.include?(:video_id)
        video_id = options.delete(:video_id)
        url += "/#{video_id}"
      end
      get(url, options)
    end

    def self.engagement_sessions(video_id, options={})
      url = "/stats/engagement/#{video_id}/sessions"
      get(url, options)
    end

  end
end