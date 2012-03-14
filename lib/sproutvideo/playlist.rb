module Sproutvideo
  class Playlist < Resource
    
    def self.create(options={})
      post("/playlists", options)
    end

    def self.list(options={})
      params = {
        :page => options.delete(:page) || 1,
        :per_page => options.delete(:per_page) || 25
      }
      params = params.merge(options)
      get("/playlists", params)
    end

    def self.details(playlist_id, options={})
      get("/playlists/#{playlist_id}", options)
    end

    def self.update(playlist_id, options={})
      put("/playlists/#{playlist_id}", options)
    end

    def self.destroy(playlist_id, options={})
      delete("/playlists/#{playlist_id}", options)
    end
  end
end