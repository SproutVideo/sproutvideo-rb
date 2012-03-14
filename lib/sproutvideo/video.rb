module Sproutvideo
  class Video < Resource
    
    def self.create(file_path='', options={})
      upload("/videos", file_path, options)
    end

    def self.list(options={})
      params = {
        :page => options.delete(:page) || 1,
        :per_page => options.delete(:per_page) || 25
      }
      params = params.merge(options)
      get("/videos", params)
    end

    def self.details(video_id, options={})
      get("/videos/#{video_id}", options)
    end

    def self.update(video_id, options={})
      put("/videos/#{video_id}", options)
    end

    def self.destroy(video_id, options={})
      delete("/videos/#{video_id}", options)
    end
  end
end