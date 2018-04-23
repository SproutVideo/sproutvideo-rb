module Sproutvideo
  class Folder < Resource
    def self.create(options = {})
      post('/folders', options)
    end

    def self.list(options={})
      params = {
        :page => options.delete(:page) || 1,
        :per_page => options.delete(:per_page) || 25
      }
      params = params.merge(options)
      get('/folders', params)
    end

    def self.details(folder_id, options = {})
      get("/folders/#{folder_id}", options)
    end

    def self.update(folder_id, options = {})
      put("/folders/#{folder_id}", options)
    end

    def self.destroy(folder_id, options = {})
      delete("/folders/#{folder_id}", options)
    end
  end
end