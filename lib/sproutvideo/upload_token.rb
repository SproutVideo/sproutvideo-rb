module Sproutvideo
  class UploadToken < Resource
    def self.create(options={})
      post("/upload_tokens", options)
    end
  end
end
