module Sproutvideo
  class LiveStream < Resource

    def self.create(options={}, file_path='')
      if file_path.empty?
        post("/live_streams", options)
      else
        upload("/live_streams", file_path, options, :custom_poster_frame)
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

    def self.update(live_stream_id, options={}, file_path='')
      if file_path.empty?
        put("/live_streams/#{live_stream_id}", options)
      else
        upload("/live_streams/#{live_stream_id}", file_path, options.merge({method: :PUT}), :custom_poster_frame)
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
