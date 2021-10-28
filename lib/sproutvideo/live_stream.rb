module Sproutvideo
  class LiveStream < Resource

    def self.create(options={})
      if options.include?(:custom_poster_frame)
        poster_frame = options.delete(:custom_poster_frame)
        upload("/live_streams", poster_frame, options, :custom_poster_frame)
      else
        post("/live_streams", options)
      end
    end

    def self.list(options={})
      params = {
        :page => options.delete(:page) || 1,
        :per_page => options.delete(:per_page) || 25
      }
      params = params.merge(options)
      get("/live_streams", params)
    end

    def self.details(live_stream_id, options={})
      get("/live_streams/#{live_stream_id}", options)
    end

    def self.update(live_stream_id, options={})
      if options.include?(:custom_poster_frame)
        poster_frame = options.delete(:custom_poster_frame)
        upload("/live_streams/#{live_stream_id}", poster_frame, options.merge({method: :PUT}), :custom_poster_frame)
      else
        put("/live_streams/#{live_stream_id}", options)
      end
    end

    def self.destroy(live_stream_id, options={})
      delete("/live_streams/#{live_stream_id}", options)
    end

    def self.end_stream(live_stream_id, options={})
      put("/live_streams/#{live_stream_id}/end_stream", options)
    end
  end
end
