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

    def self.signed_embed_code(video_id, params={}, expires=nil, protocol='http')
      #get video
      resp = get("/videos/#{video_id}")
      generate_signed_embed_code(resp, params, expires, protocol)
    end

    def self.generate_signed_embed_code(resp, params={}, expires=nil, protocol='http')
      video_id = resp.body[:id] 
      token = resp.body[:security_token]
      
      host = 'videos.sproutvideo.com'
      path = "/embed/#{video_id}/#{token}"
      string_to_sign = "GET\n"
      string_to_sign << "#{host}\n"
      string_to_sign << "#{path}\n"
      
      expires = Time.now.to_i + 300 unless expires

      params = params.merge('expires' => expires)

      url_params = ""
      actual_url_params = ""
      params.sort_by{|k,_|k}.each do |key, value|
          value = value.to_s.strip
          url_params << "&#{key}=#{CGI::unescape(value)}"
          actual_url_params << "&#{key}=#{value}"
      end

      string_to_sign << "#{url_params}"

      digest = OpenSSL::Digest::Digest.new('sha1')
      b64_hmac = [OpenSSL::HMAC.digest(digest, Sproutvideo.api_key, string_to_sign)].pack("m").strip
      signature = CGI.escape(b64_hmac) 
    
      "#{protocol}://#{host}#{path}?signature=#{signature}#{actual_url_params}"
    end

  end
end