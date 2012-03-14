module Sproutvideo
  class Tag < Resource
    
    def self.create(options={})
      post("/tags", options)
    end

    def self.list(options={})
      params = {
        :page => options.delete(:page) || 1,
        :per_page => options.delete(:per_page) || 25
      }
      params = params.merge(options)
      get("/tags", params)
    end

    def self.details(tag_id, options={})
      get("/tags/#{tag_id}", options)
    end

    def self.update(tag_id, options={})
      put("/tags/#{tag_id}", options)
    end

    def self.destroy(tag_id, options={})
      delete("/tags/#{tag_id}", options)
    end
  end
end